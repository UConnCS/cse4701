let books = await client.book.findMany({});
console.table(books);

let count = await client.book.count({});
console.log('Total records:', count);