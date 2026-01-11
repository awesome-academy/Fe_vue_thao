create_table :leave_requests_duplicates, id: false do |t|
  t.bigint :original_id
  t.json :data
  t.datetime :backed_up_at
end
duplicates = execute <<~SQL
  SELECT *
  FROM leave_requests
  WHERE (student_id, date) IN (
    SELECT student_id, date
    FROM leave_requests
    GROUP BY student_id, date
    HAVING COUNT(*) > 1
  )
  AND id NOT IN (
    SELECT MIN(id)
    FROM leave_requests
    GROUP BY student_id, date
  );
SQL

duplicates.each do |row|
  execute <<~SQL
    INSERT INTO leave_requests_duplicates
    VALUES (#{row['id']}, '#{row.to_json}', NOW());
  SQL
end
