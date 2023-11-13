let books = await client.book.findMany({
    where: {
        name: {
            equals: 'The Lost Tribe'
        }
    },
    select: {
        book_id: true
    }
})

console.table(books);