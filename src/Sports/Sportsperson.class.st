"
""клас атлета""

"
Class {
	#name : 'Sportsperson',
	#superclass : 'Object',
	#instVars : [
		'lastName',
		'age',
		'nationality'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'as yet unclassified' }
Sportsperson class >> loadFromTxtFile [
    | file stream lastNameva ageva nationalityva athlete |
    file := 'sportPerson.txt' asFileReference.
    stream := file readStream.
    lastNameva := (stream nextLine findTokens: ':') second.
    ageva := (stream nextLine findTokens: ':') second asInteger.
    nationalityva := (stream nextLine findTokens: ':') second.
    athlete := self new initializeWithLastName: lastNameva age: ageva nationality: nationalityva.
    stream close.
    ^athlete

"поки шо робочий лише цей метод, але я працюю над тим щоб виводило колекцію з файлу нормально, бо воно працювало, але я шось наробила і воно вже не працює"
]

{ #category : 'as yet unclassified' }
Sportsperson class >> loadFromTxtFileCollection [
 | file stream lastNameval ageval nationalityval athlete athletesCollection |
    file := 'SportPerson1.txt' asFileReference.
    stream := file readStream.  
    athletesCollection := OrderedCollection new.  
    [stream atEnd] whileFalse: [
        lastNameval := (stream nextLine findTokens: ':') second.
        ageval := (stream nextLine findTokens: ':') second asInteger.
        nationalityval := (stream nextLine findTokens: ':') second.
        athlete := self new initializeWithLastName: lastNameval age: ageval nationality: nationalityval.
        athletesCollection add: athlete.
    ].
    stream close.
    ^athletesCollection.
]

{ #category : 'arithmetic' }
Sportsperson >> + years [
    (years isNumber and: [ years >= 0 ]) ifTrue: [
        age := age + years ].
    ^ self.



]

{ #category : 'comparing' }
Sportsperson >> < anotherSportsperson [
    ^ self totalEarnings < anotherSportsperson totalEarnings.

]

{ #category : 'comparing' }
Sportsperson >> <= anotherSportsperson [
    ^ self totalEarnings <= anotherSportsperson totalEarnings.

]

{ #category : 'comparing' }
Sportsperson >> = anotherSportsperson [
    ^ self totalEarnings = anotherSportsperson totalEarnings.

]

{ #category : 'comparing' }
Sportsperson >> > anotherSportsperson [
    ^ self totalEarnings > anotherSportsperson totalEarnings.
]

{ #category : 'comparing' }
Sportsperson >> >= anotherSportsperson [
    ^ self totalEarnings >= anotherSportsperson totalEarnings.
]

{ #category : 'accessing' }
Sportsperson >> age [
    ^ age.
]

{ #category : 'accessing' }
Sportsperson >> displayInformation [
    ^ String streamContents: [ :stream |
        stream
            nextPutAll: 'Last Name: '; nextPutAll: lastName; cr;
            nextPutAll: 'Age: '; nextPutAll: age asString; cr;
            nextPutAll: 'Nationality: '; nextPutAll: nationality; cr ].
]

{ #category : 'comparing' }
Sportsperson >> earningsLessThan: anotherSportsperson [
    ^ self totalEarnings < anotherSportsperson totalEarnings.
]

{ #category : 'initialization' }
Sportsperson >> initializeWithLastName: aLastName age: anAge nationality: aNationality [
    lastName := aLastName.
    age := anAge.
    nationality := aNationality.
]

{ #category : 'accessing' }
Sportsperson >> lastName [
    ^ lastName.
]

{ #category : 'accessing' }
Sportsperson >> nationality [
    ^ nationality.
]

{ #category : 'as yet unclassified' }
Sportsperson >> saveToFile: anObject [
    | file stream |
    
    file := 'sportPerson.txt' asFileReference.
    stream := file writeStream.

    anObject isCollection
        ifTrue: [
            anObject do: [:athlete |
                stream nextPutAll: athlete displayInformation. 
            ].
        ]
        ifFalse: [
            stream nextPutAll: anObject displayInformation.
        ].
    
    stream close.
    Transcript show: 'файно є'; cr.
"короче, метод цей може записувати як один обєкт так і колекцію, я початку зробила два окремі методи, але мені вже трішки поплавило мізки, я вже не знаю як має бути"
]

{ #category : 'accessing' }
Sportsperson >> totalEarnings [
    self subclassResponsibility.
]

{ #category : 'writing' }
Sportsperson >> writeOn: aStream [
    aStream
        nextPutAll: 'Last Name: ', lastName; cr;
        nextPutAll: 'Age: ', age asString; cr;
        nextPutAll: 'Nationality: ', nationality; cr.
]
