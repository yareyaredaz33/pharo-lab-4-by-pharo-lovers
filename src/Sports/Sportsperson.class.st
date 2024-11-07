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
	#classVars : [
		'SportspersonCollection'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'as yet unclassified' }
Sportsperson class >> displayOtherCountryAthletes: aCollection nationality: country [
        | ukrainians |
        
        "Фільтруємо українських спортсменів"
        ukrainians := aCollection select: [ :athlete | athlete nationality = country ].

        "Виводимо інформацію про українських спортсменів"
        Transcript show: 'спортсмени з ',country,': '; cr.
        ukrainians do: [ :each | 
            Transcript show: 'Прізвище: ', each lastName, ', Прибуток: ', each totalEarnings asString, ', Вид спорту: ', each sportType; cr.
        ].
    
]

{ #category : 'as yet unclassified' }
Sportsperson class >> displayUkrainianAthletes: aCollection [ 
        | ukrainians |
        
        "Фільтруємо українських спортсменів"
        ukrainians := aCollection select: [ :athlete | athlete nationality = 'Ukraine' ].

        "Виводимо інформацію про українських спортсменів"
        Transcript show: 'Українські спортсмени:'; cr.
        ukrainians do: [ :each | 
            Transcript show: 'Прізвище: ', each lastName, ', Прибуток: ', each totalEarnings asString, ', Вид спорту: ', each sportType; cr.
        ].
    
]

{ #category : 'as yet unclassified' }
Sportsperson class >> findLargestEarningsIn: aCollection [ [
    | maxEarnings |

    "Знаходимо максимальний прибуток серед спортсменів"
    maxEarnings := aCollection inject: 0 into: [ :currMax :sportsperson | 
        currMax max: sportsperson totalEarnings 
    ].

    "Повертаємо всіх спортсменів з максимальним прибутком"
  ^ aCollection select: [ :sportsperson | sportsperson totalEarnings = maxEarnings ]
          collect: [ :sportsperson | sportsperson surname ].

]
]

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

{ #category : 'adding' }
Sportsperson >> addNewSportspersonFromDialog [ 
    
  Transcript show: 'Додано нового спортсмена: '; cr.
    lastName := UIManager default request: 'Введіть прізвище спортсмена:'.
   [ 
        age := UIManager default request: 'Введіть вік спортсмена:'. 
        (age isAllDigits) 
    ] whileFalse: [ 
        UIManager default inform: 'Вік має бути числом! Будь ласка, спробуйте знову.'. 
    ].
    age := age asNumber.
    nationality := UIManager default request: 'Введіть національність спортсмена:'.

    

      Transcript show: 'Додано нового спортсмена: '; cr;
               show: 'Прізвище: ', lastName; cr;
               show: 'Вік: ', age asString; cr;
               show: 'Національність: ', nationality; cr.


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
Sportsperson >> initializeCollection [ [
    "Ініціалізуємо колекцію для спортсменів"
    SportspersonCollection := OrderedCollection new.
]
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

{ #category : 'printing' }
Sportsperson >> printEarnings [
    "This method will be overridden in subclasses"
    Transcript show: 'Earnings not available for: ', lastName; cr.
]

{ #category : 'as yet unclassified' }
Sportsperson >> promptToAdd [
    | lastName age nationality type newSportsperson sportsCollection |
    
    "Prompt for the type of sportsperson"
    type := UIManager default chooseFrom: #('Tennis Player' 'Football Player') 
                        values: { TennisPlayer . FootballPlayer } 
                        title: 'Choose the type of sportsperson to add'.

    "Prompt for last name"
    lastName := UIManager default request: 'Enter the last name:'.
    
    "Prompt for age and convert it to an integer"
    age := (UIManager default request: 'Enter the age:') asInteger.
    
    "Prompt for nationality"
    nationality := UIManager default request: 'Enter the nationality:'.

    "Create the appropriate sportsperson instance based on the selected type"
    newSportsperson := type new initializeWithLastName: lastName age: age nationality: nationality.

    "Add the new sportsperson to the collection"
    sportsCollection add: newSportsperson.

    ^ newSportsperson.

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

{ #category : 'as yet unclassified' }
Sportsperson >> sportType [ 
        ^ nil. 
    
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
