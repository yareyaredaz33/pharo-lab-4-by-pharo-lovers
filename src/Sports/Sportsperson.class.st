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

{ #category : 'as yet unclassified' }
Sportsperson >> displayInformationInTranscript [
    Transcript show: (self displayInformation); cr.
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
