SELECT DISTINCT ON (name, post_count) * FROM (
(SELECT tags.id, tags.name, tags.post_count, tags.category, null AS antecedent_name FROM
"tags" WHERE (tags.name LIKE $1 ESCAPE E'\\') AND (post_count > 0) ORDER BY post_count desc LIMIT 10)
UNION ALL
(SELECT tags.id, tags.name, tags.post_count, tags.category, tag_aliases.antecedent_name
FROM "tag_aliases"
INNER JOIN tags ON tags.name = tag_aliases.consequent_name
WHERE (tag_aliases.antecedent_name LIKE $1 ESCAPE E'\\') AND "tag_aliases"."status" IN ('active', 'processing', 'queued') AND (tags.name NOT LIKE $1 ESCAPE E'\\') AND (tag_aliases.post_count > 0) ORDER BY tag_aliases.post_count desc LIMIT 20)) AS unioned_query ORDER BY post_count desc LIMIT 10
