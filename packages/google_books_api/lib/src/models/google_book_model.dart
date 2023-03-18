class GoogleBookModel {
  const GoogleBookModel({
    required this.id,
    required this.title,
    this.description,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.pageCount,
    required this.averageRating,
    required this.ratingsCount,
    required this.isMature,
    required this.imageUrl,
    required this.infoUrl,
    required this.isbn10,
    required this.isbn13,
  });

  final String id;
  final String title;
  final String? description;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final int? pageCount;
  final double? averageRating;
  final int? ratingsCount;
  final bool isMature;
  final String? imageUrl;
  final String infoUrl;
  final String? isbn10;
  final String? isbn13;

  get linkName {
    String name = title.toLowerCase();

    // remove punctuation
    name = name.replaceAll(RegExp(r'[^\w\s]+'), '');

    // replace spaces with dashes
    name = name.replaceAll(' ', '-');

    if (authors == null) {
      return name;
    }

    String authorsString = authors!.join('_').toLowerCase();

    // remove punctuation
    authorsString = authorsString.replaceAll(RegExp(r'[^\w\s]+'), '');

    // replace spaces with dashes
    authorsString = authorsString.replaceAll(' ', '-');

    return '${name}_by_$authorsString';
  }

  // to string
  @override
  String toString() {
    return 'GoogleBookModel($title, $authors)';
  }

  factory GoogleBookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>;
    final saleInfo = json['saleInfo'] as Map<String, dynamic>;
    final accessInfo = json['accessInfo'] as Map<String, dynamic>;
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
    final authors = volumeInfo['authors'] as List<dynamic>?;
    final rating = double.tryParse(volumeInfo['averageRating'].toString());
    final industryIdentifiers =
        volumeInfo['industryIdentifiers'] as List<dynamic>?;

    String? isbn10;
    String? isbn13;

    if (industryIdentifiers != null) {
      for (final industryIdentifier in industryIdentifiers) {
        final type = industryIdentifier['type'] as String;
        final identifier = industryIdentifier['identifier'] as String;

        if (type == 'ISBN_10') {
          isbn10 = identifier;
        } else if (type == 'ISBN_13') {
          isbn13 = identifier;
        }
      }
    }

    return GoogleBookModel(
      id: json['id'] as String,
      title: volumeInfo['title'] as String,
      description: volumeInfo['description'] as String?,
      authors: authors?.map((e) => e as String).toList(),
      publisher: volumeInfo['publisher'] as String?,
      publishedDate: volumeInfo['publishedDate'] as String?,
      pageCount: volumeInfo['pageCount'] as int?,
      averageRating: rating,
      ratingsCount: volumeInfo['ratingsCount'] as int?,
      isMature: saleInfo['isEbook'] as bool,
      imageUrl: imageLinks == null ? null : imageLinks['thumbnail'] as String,
      infoUrl: accessInfo['webReaderLink'] as String,
      isbn10: isbn10,
      isbn13: isbn13,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'authors': authors,
        'publisher': publisher,
        'publishedDate': publishedDate,
        'pageCount': pageCount,
        'averageRating': averageRating,
        'ratingsCount': ratingsCount,
        'isMature': isMature,
        'imageUrl': imageUrl,
        'infoUrl': infoUrl,
        'isbn10': isbn10,
        'isbn13': isbn13,
      };
}

void main() {
  final book = GoogleBookModel.fromJson(s);

  print(book.toJson());
}

final s = {
  "kind": "books#volume",
  "id": "8U2oAAAAQBAJ",
  "etag": "D2LSfU+gOeo",
  "selfLink": "https://www.googleapis.com/books/v1/volumes/8U2oAAAAQBAJ",
  "volumeInfo": {
    "title": "Steve Jobs",
    "authors": ["Walter Isaacson"],
    "publisher": "Simon and Schuster",
    "publishedDate": "2011",
    "description":
        "Draws on more than forty interviews with Steve Jobs, as well as interviews with family members, friends, competitors, and colleagues to offer a look at the co-founder and leading creative force behind the Apple computer company.",
    "industryIdentifiers": [
      {"type": "ISBN_13", "identifier": "9781451648546"},
      {"type": "ISBN_10", "identifier": "1451648545"}
    ],
    "readingModes": {"text": false, "image": false},
    "pageCount": 656,
    "printType": "BOOK",
    "categories": ["Biography & Autobiography"],
    "averageRating": 4,
    "ratingsCount": 3906,
    "maturityRating": "NOT_MATURE",
    "allowAnonLogging": false,
    "contentVersion": "0.4.2.0.preview.0",
    "panelizationSummary": {
      "containsEpubBubbles": false,
      "containsImageBubbles": false
    },
    "imageLinks": {
      "smallThumbnail":
          "http://books.google.com/books/content?id=8U2oAAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
      "thumbnail":
          "http://books.google.com/books/content?id=8U2oAAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
    },
    "language": "en",
    "previewLink":
        "http://books.google.lt/books?id=8U2oAAAAQBAJ&pg=PA590&dq=steve+jobs&hl=&cd=3&source=gbs_api",
    "infoLink":
        "http://books.google.lt/books?id=8U2oAAAAQBAJ&dq=steve+jobs&hl=&source=gbs_api",
    "canonicalVolumeLink":
        "https://books.google.com/books/about/Steve_Jobs.html?hl=&id=8U2oAAAAQBAJ"
  },
  "saleInfo": {
    "country": "LT",
    "saleability": "NOT_FOR_SALE",
    "isEbook": false
  },
  "accessInfo": {
    "country": "LT",
    "viewability": "PARTIAL",
    "embeddable": true,
    "publicDomain": false,
    "textToSpeechPermission": "ALLOWED_FOR_ACCESSIBILITY",
    "epub": {"isAvailable": false},
    "pdf": {"isAvailable": false},
    "webReaderLink":
        "http://play.google.com/books/reader?id=8U2oAAAAQBAJ&hl=&source=gbs_api",
    "accessViewStatus": "SAMPLE",
    "quoteSharingAllowed": false
  },
  "searchInfo": {
    "textSnippet":
        "Bro Uttal, “Behind the Fall of <b>Steve Jobs</b>,” Fortune, Aug. 5, 1985; Sculley, 249–260; rose, 275–290; Young, 396–404. Like a Rolling Stone: Interviews with Mike Murray, Mike Markkula, <b>Steve Jobs</b>, John Sculley, Bob Metcalfe, George riley,&nbsp;..."
  }
};
