let connection = await pool.getConnection();
let rows = await connection.query(`
    SELECT
        l.Book_id, b.Title
    FROM Book_Loans l
    INNER JOIN Borrower u
        ON l.Card_no = u.Card_no
    INNER JOIN Book b
        ON l.Book_id = b.Book_id
    WHERE u.Name="Ramesh Narayan";
`);

let matched = await Promise.all(rows.map(async (row: any) => {
    let book = await client.book.findUnique({ where: { book_id: row.Book_id } });
    if (!book) {
        console.warn(`No match for Book ${row.Book_id} in Mongo!`);
        return null;
    }

    return {
        ...row,
        image: book.image
    };
}));

for (let ent of matched) {
    let { Book_id: id, image } = ent;
    if (!image) continue;

    let buf = Buffer.from(image, 'base64');
    let path = `./covers/${id}.jpg`;
    console.log(`Writing ${path}`);
    writeFileSync(path, buf);
}

console.log('Done.');