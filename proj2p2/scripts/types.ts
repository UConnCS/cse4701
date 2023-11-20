export type BookJson = {
    id: string;
    bookname: string;
    author: string | string[];
    language?: string;
    printlength: string;
    publicationyear?: string;
    format: BookFormat | 'Unavailable';
}

export type BookFormat = {
    paperback?: string;
    hardcover?: string;
    audiobook?: string;
    kindle?: string;
}

export type BookMap = {
    [bookId: string]: {
        book: BookJson;
        image?: Buffer;
    }
}