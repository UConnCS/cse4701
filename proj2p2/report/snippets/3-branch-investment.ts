let connection = await pool.getConnection();
let rows = await connection.query(`SELECT * FROM Book_Copies;`);

const books = await client.book.findMany();
const prices = books
    .map(book => book.description as any)
    .map(json => ({
        id: json.id,
        amount: parseFloat(json.format?.paperback?.substring(1)) ?? 0
    }));

const branchBooks = rows.map((row: any) => {
    const price = prices.find(price => price.id === row.Book_id);
    if (!price) return NaN;
    return {
        branchId: row.Branch_id,
        bookId: row.Book_id,
        investment: price.amount * row.No_of_copies
    }
});

let branches = branchBooks.reduce((acc: any, curr: any) => {
    if (!acc[curr.branchId]) acc[curr.branchId] = 0;
    acc[curr.branchId] += Math.round(curr.investment * 100) / 100;
    return acc;
}, {});

console.table(branches);