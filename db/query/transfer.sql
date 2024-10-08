-- name: CreateTransfer :one
INSERT into transfers (
    from_account_id,
    to_account_id,
    amount
) VALUES (
    $1, $2, $3
)
RETURNING *;

-- name: ListTransfers :many
SELECT * FROM transfers
WHERE
    from_account_id = $1 OR
    to_account_id = $2
ORDER BY id
LIMIT $3
OFFSET $4;

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

