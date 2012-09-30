ActivityLog.register(:blog_entry, BlogEntryLogDecorator, %{
  SELECT
    'blog_entry' AS type,
    updated_at AS created_at,
    (SELECT name FROM users WHERE id = updater_id) AS user_name,
    'updated' AS event,
    title AS name,
    id,
    NULL::integer AS parent_id
  FROM blog_entries
  ORDER BY updated_at
})
