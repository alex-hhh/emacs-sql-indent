-- SQL from https://ddrscott.github.io/blog/2017/what-the-sql-lateral/

SELECT
  t2.up_seconds
  from (
    -- build virtual table of all hours between
    -- a date range
    SELECT
      start_ts,
      start_ts + interval '1 hour' AS end_ts
      FROM generate_series('2017-03-01'::date,
                           '2017-03-03'::timestamp - interval '1 hour',
                           interval '1 hour')
             AS t(start_ts))
         AS cal
       LEFT JOIN (
         -- build virtual table of uptimes
         SELECT *
           FROM (
             VALUES
             ('2017-03-01 01:15:00-06'::timestamp, '2017-03-01 02:15:00-06'::timestamp),
             ('2017-03-01 08:00:00-06', '2017-03-01 20:00:00-06'),
             ('2017-03-02 19:00:00-06', null))
                  AS t(start_ts, end_ts))
                   AS uptime
           ON cal.end_ts > uptime.start_ts AND cal.start_ts <= coalesce(uptime.end_ts, current_timestamp)
       JOIN LATERAL (
         SELECT
         -- will use `first_ts` and `last_ts` to calculate uptime duration
           CASE WHEN uptime.start_ts IS NOT NULL THEN
                                                 greatest(uptime.start_ts, cal.start_ts)
           END                                               AS first_ts,
           least(cal.end_ts, uptime.end_ts)                  AS last_ts,
           date_trunc('day', cal.start_ts)::date             AS cal_date,
           extract(hour from cal.start_ts)                   AS cal_hour,
           extract(epoch from age(cal.end_ts, cal.start_ts)) AS cal_seconds)
                      as t1 ON true
       JOIN LATERAL (
         -- calculate uptime seconds for the time slice
         SELECT
           coalesce(
             extract(epoch FROM age(last_ts, first_ts)),
             0
           )
             AS up_seconds
       ) t2 ON true;

-- SQL from https://github.com/alex-hhh/emacs-sql-indent/issues/99#issuecomment-833821835
--
-- newline after JOIN LATERAL is correctly detected.

SELECT reports.diagnostic_report_version_id,
       image_descriptors.order,
       image_descriptors.descriptor,
       files.file_name as name,
       files.file_id as id,
       files.content_type
  FROM diagnostic_report_versions as reports,
       files
  JOIN LATERAL
       jsonb_to_recordset(jsonb_path_query_array(reports.tree, 'strict $.children.report.children.images.children.*'))
       AS image_descriptors("name" text, "order" text, "descriptor" jsonb)
 WHERE reports.diagnostic_report_version_id = files.diagnostic_report_version_id
   AND files.file_id = image_descriptors.NAME
