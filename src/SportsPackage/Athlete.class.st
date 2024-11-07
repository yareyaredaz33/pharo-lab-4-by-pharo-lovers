Class {
	#name : 'Athlete',
	#superclass : 'Object',
	#instVars : [
		'surname',
		'age',
		'nationality'
	],
	#category : 'SportsPackage',
	#package : 'SportsPackage'
}

{ #category : 'instance creation' }
Athlete class >> newSurname: aSurname age: anAge nationality: aNationality [ [
    ^ self new initializeSurname: aSurname age: anAge nationality: aNationality.
]
]

{ #category : 'comparing' }
Athlete >> = anObject [ [
    ^ (anObject isKindOf: self class)
        and: [ surname = anObject surname and: [ age = anObject age ] ].
]
]

{ #category : 'accessing' }
Athlete >> age [ [
    ^ age.
]
]

{ #category : 'initialization' }
Athlete >> initialize [
 | aSurname anAge aNationality|
    super initialize.
    surname := aSurname ifNil: ['Unknown'].
    age := anAge ifNil: [0].
    nationality := aNationality ifNil: ['Unknown'].
]

{ #category : 'accessing' }
Athlete >> nationality [ [
    ^ nationality.
]
]

{ #category : 'printing' }
Athlete >> printOn: aStream [ [
    Transcript show: 'Printing athlete info...'; cr.
    aStream
        nextPutAll: 'Athlete: '; nextPutAll: surname;
        nextPutAll: ', Age: '; nextPutAll: age asString;
        nextPutAll: ', Nationality: '; nextPutAll: nationality.
]
]

{ #category : 'printing' }
Athlete >> printString [ [
    ^ 'Athlete: ', surname, ', Age: ', age asString, ', Nationality: ', nationality.
]
]

{ #category : 'accessing' }
Athlete >> surname [ [
    ^ surname.
]
]
