let book = await client.book.findUnique({
    where: { book_id: 'B1' }
});

console.log(book);