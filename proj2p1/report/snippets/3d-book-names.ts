let books = await client.book.findMany({
    select: { name: true }
});

console.table(books);