ActivityLog.register(:blog_entry, BlogEntryLogDecorator, %{
  SELECT
    'blog_entry' AS type,
    updated_at AS created_at,
    (SELECT name FROM users WHERE id = updater_id) AS user_name,
    update_status(created_at, updated_at) AS event,
    title AS name,
    id,
    NULL::integer AS parent_id
  FROM blog_entries
  ORDER BY updated_at
})

ActivityLog.register(:blog_comment, BlogCommentLogDecorator, %{
  SELECT
    'blog_comment' AS type,
    updated_at AS created_at,
    name AS user_name,
    'added' AS event,
    'Comment on ''' || (SELECT title FROM blog_entries WHERE id = blog_entry_id) || '''' AS name,
    id,
    blog_entry_id AS parent_id
  FROM blog_comments
  ORDER BY updated_at
})
