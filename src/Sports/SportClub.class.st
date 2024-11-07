"
""клас спортивного клубу""
"
Class {
	#name : 'SportClub',
	#superclass : 'Object',
	#instVars : [
		'name',
		'members'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'as yet unclassified' }
SportClub class >> someTestMethod [
    Transcript show: 'someTestMethod called'; cr.
]

{ #category : 'adding' }
SportClub >> addSportsperson: anAthlete [ 
    members add: anAthlete.
]

{ #category : 'adding' }
SportClub >> addSportspersonFromDialog [ 
    | lastName age nationality sportType sportsperson |

    lastName := UIManager default request: 'Введіть прізвище спортсмена:'.
    [
        age := UIManager default request: 'Введіть вік спортсмена:'.
        (age isAllDigits)
    ] whileFalse: [
        UIManager default inform: 'Вік має бути числом! Будь ласка, спробуйте знову.'.
    ].
    age := age asInteger.
    nationality := UIManager default request: 'Введіть національність спортсмена:'.
    sportType := UIManager default request: 'Введіть тип спортсмена (FootballPlayer або TennisPlayer):'.

    "Створюємо спортсмена на основі вибраного типу"
    sportsperson := sportType = 'FootballPlayer'
        ifTrue: [ FootballPlayer new initializeWithLastName: lastName age: age nationality: nationality club: '' contract: 0 goals: 0 ]
        ifFalse: [ TennisPlayer new initializeWithLastName: lastName age: age nationality: nationality worldRanking: 0 earnings: #() ].
    
    "Додаємо спортсмена до колекції"
    self addSportsperson: sportsperson.

    self createMenuMorph.
]

{ #category : 'as yet unclassified' }
SportClub >> athleteNames [ 
    "Список прізвищ спортсменів для відображення в вікні"
    ^ members collect: [ :athlete | athlete lastName ].
]

{ #category : 'as yet unclassified' }
SportClub >> createMenuMorph [
    | menuMorph |

    "Create a new MorphMenu"
    menuMorph := MenuMorph new.

    "Add menu items with actions"
    menuMorph add: 'Додати спортсмена'
        target: self
        selector: #addSportspersonFromDialog.

    menuMorph add: 'Вивести інформацію про спортсменів'
        target: self
        selector: #displayAllMembers.

    menuMorph add: 'Переглянути контракти спортсменів'
        target: self
        selector: #reviewContracts.

    menuMorph add: 'Переглянути інформацію про клуб'
        target: self
        selector: #displayClubInfo.

    menuMorph add: 'Переглянути гравця з найвищою зарплатою'
        target: self
        selector: #highestPaidAthlete.

    ^ menuMorph.
]

{ #category : 'display' }
SportClub >> displayAllMembers [ 
    members do: [ :athlete | athlete displayInformationInTranscript ].
]

{ #category : 'display' }
SportClub >> displayClubInfo [ 
    ^ String streamContents: [ :stream |
        stream
            nextPutAll: 'Назва клубу: '; nextPutAll: name; cr;
            nextPutAll: 'Члени клубу: '; cr.
        members do: [ :athlete |
            stream nextPutAll: athlete displayInformation.
            stream cr.
        ].
    ].
]

{ #category : 'printing' }
SportClub >> displayClubInfoTranscript [ 
    Transcript show: 'Назва клубу: ', name; cr.
    Transcript show: 'Члени клубу: '; cr.
    members do: [ :athlete | Transcript show: athlete displayInformation; cr ].
]

{ #category : 'finding/searching' }
SportClub >> findSportspersonByLastName: lastName [ 
    ^ members detect: [ :athlete | athlete lastName = lastName ] ifNone: [ nil ].
]

{ #category : 'review contracts' }
SportClub >> highestPaidAthlete [ 
    ^ members detect: [ :athlete | athlete totalEarnings = (members collect: [ :each | each totalEarnings ]) max ].
]

{ #category : 'initialization' }
SportClub >> initializeWithName: clubName [ 
    name := clubName.
    members := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
SportClub >> loadClubFromFile [ 
    | file stream lastNameval ageval nationalityval athlete line clubval contractval goals worldRanking earnings |

    file := 'sportClub.txt' asFileReference.
    stream := file readStream.

    [stream atEnd] whileFalse: [
        line := stream nextLine.
        line isEmpty ifTrue: [ ^self ].

        lastNameval := (line findTokens: ':') second.

        line := stream nextLine.
        ageval := (line findTokens: ':') second asInteger.

        line := stream nextLine.
        nationalityval := (line findTokens: ':') second.

        line := stream nextLine.
        (line indexOf: 'Club:') = 1 ifTrue: [
            "Футболіст"
            clubval := (line findTokens: ':') second.

            line := stream nextLine.
            contractval := (line findTokens: ':') second asInteger.

            line := stream nextLine.
            goals := (line findTokens: ':') second asInteger.

            athlete := FootballPlayer new 
                initializeWithLastName: lastNameval 
                age: ageval 
                nationality: nationalityval 
                club: clubval 
                contract: contractval 
                goals: goals.
        ] ifFalse: [
            "Тенісист"
            worldRanking := (line findTokens: ':') second asInteger.

            line := stream nextLine.
            earnings := (line findTokens: ':') second asArray.

            athlete := TennisPlayer new
                initializeWithLastName: lastNameval
                age: ageval
                nationality: nationalityval
                worldRanking: worldRanking
                earnings: earnings.
        ].
        self addSportsperson: athlete.
    ].

    stream close.
    Transcript show: 'Завантажено дані з файлу'; cr.
]

{ #category : 'review contracts' }
SportClub >> manualReviewContracts [
    ^ String streamContents: [ :stream |
        stream nextPutAll: 'Перегляд контрактів...'; cr.
        self reviewContracts.

        stream nextPutAll: 'Найоплачуваніший спортсмен: '; cr.
        stream nextPutAll: (self highestPaidAthlete displayInformation); cr.
    ].
]

{ #category : 'accessing' }
SportClub >> members [ 
    ^ members.
]

{ #category : 'accessing' }
SportClub >> members: aCollection [ 
    members := aCollection.
]

{ #category : 'accessing' }
SportClub >> name [ 
    ^ name.
]

{ #category : 'accessing' }
SportClub >> name: aName [ 
    name := aName.
]

{ #category : 'printing' }
SportClub >> printCategoryInfo: aCategory [ 
    Transcript show: 'Список спортсменів категорії: ', aCategory; cr.

    (members select: [ :athlete | athlete sportType = aCategory ]) do: [ :athlete |
        Transcript show: athlete displayInformation; cr.
    ].
]

{ #category : 'removing' }
SportClub >> removeAthletesMatching: aBlock [ 
    | initialCount removedAthletes resultMessage |

    initialCount := members size.
    removedAthletes := members select: aBlock.
    members := members reject: aBlock.

    resultMessage := String streamContents: [ :stream |
        (removedAthletes isEmpty)
            ifTrue: [ stream nextPutAll: 'Нікого не видалено'; cr ]
            ifFalse: [
                stream nextPutAll: 'Видалено спортсменів: '; cr.
                removedAthletes do: [ :athlete | stream nextPutAll: athlete lastName; cr ].
            ].
    ].

    ^ resultMessage.
]

{ #category : 'removing' }
SportClub >> removeSportsperson: anAthlete [ 
    members remove: anAthlete ifAbsent: [ Transcript show: 'Спортсмен не знайдений у клубі.'; cr ].
]

{ #category : 'review contracts' }
SportClub >> reviewContracts [ 
    ^ String streamContents: [ :stream |
        members do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
            stream nextPutAll: 'Заробітки: '; nextPutAll: athlete totalEarnings asString; cr.
        ].
    ].
]

{ #category : 'accessing' }
SportClub >> totalMembers [ 
    ^ members size.
]
