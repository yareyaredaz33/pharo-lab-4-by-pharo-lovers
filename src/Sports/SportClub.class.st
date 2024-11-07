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
    nationality := UIManager default request: 'Введіть національність спортсмена:'.
    sportType := UIManager default request: 'Введіть тип спортсмена (FootballPlayer або TennisPlayer):'.

    "Створюємо спортсмена на основі вибраного типу"
    sportsperson := sportType = 'FootballPlayer'
        ifTrue: [ FootballPlayer new initializeWithLastName: lastName age: age nationality: nationality club: '' contract: 0 goals: 0 ]
        ifFalse: [ TennisPlayer new initializeWithLastName: lastName age: age nationality: nationality worldRanking: 0 earnings: #() ].
"TODO: add transcript output that sportsman is added. preferably add the person itself."
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
   "TODO: maybe rework the appearance of menu, look into other methods."
    "Return the menu morph to be added to the window or other morph"
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
SportClub >> displayClubInfoTranscrip [ 
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
  "  stream nextLine. "

    [stream atEnd] whileFalse: [
        line := stream nextLine.
        line isEmpty ifTrue: [ ^self. ].

        lastNameval := (line findTokens: ':') size > 1 ifTrue: [
            (line findTokens: ':') second
        ] ifFalse: [ ^self. ].

        line := stream nextLine.
        ageval := (line findTokens: ':') size > 1 ifTrue: [
            (line findTokens: ':') second asInteger
        ] ifFalse: [ ^self. ].

        line := stream nextLine.
        nationalityval := (line findTokens: ':') size > 1 ifTrue: [
            (line findTokens: ':') second
        ] ifFalse: [ ^self. ].


       line := stream nextLine.
        (line indexOf: 'Club:') = 1 ifTrue: [
            "Футболіст"
            clubval := (line findTokens: ':') second.
            
            line := stream nextLine.
            contractval := (line findTokens: ':') size > 1 ifTrue: [
                (line findTokens: ':') second asInteger
            ] ifFalse: [ ^self. ].

            line := stream nextLine.
            goals := (line findTokens: ':') size > 1 ifTrue: [
                (line findTokens: ':') second asInteger
            ] ifFalse: [ ^self. ].

            athlete := FootballPlayer new 
                initializeWithLastName: lastNameval 
                age: ageval 
                nationality: nationalityval 
                "club: clubval 
                annualContract: contractval 
                goalsScored: goals.
"
        ] ifFalse: [
            "Тенісист"
            worldRanking := (line findTokens: ':') size > 1 ifTrue: [
                (line findTokens: ':') second asInteger
            ] ifFalse: [ ^self. ].

            line := stream nextLine.
            earnings := (line findTokens: ':') size > 1 ifTrue: [
                (line findTokens: ':') second asInteger
            ] ifFalse: [ ^self. ].

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


{ #category : 'as yet unclassified' }
SportClub >> openMainWindow [ 
    | window athleteListPane |

    window := SystemWindow labelled: 'Спортивний клуб - ', name.
  "  window label: 'Спортивний клуб - ', name."

  "Вікно для відображення спортсменів"
  "  athleteListPane := PluggableListMorph on: self list: #athleteNames selection: nil.
    window addMorph: athleteListPane frame: (0 @ 0 corner: 1 @ 0.6).
"
    "Додаємо меню"
    window addMorph: (self createMenuMorph) frame: (0 @ 0 corner: 1 @ 1).
   "TODO: please make this menu reopen after calling."
    window openInWorld.

]

{ #category : 'printing' }
SportClub >> printCategoryInfo: aCategory [ 
    Transcript show: 'Список спортсменів категорії: ', aCategory; cr.

    (members select: [ :athlete | athlete sportType = aCategory ]) do: [ :athlete |
        Transcript show: athlete displayInformation; cr.
    ].



]

{ #category : 'printing' }
SportClub >> printTopScorers [ 
    | topScorers |
    
    topScorers := self topScorers.
    
    Transcript show: 'Топ гравці за кількістю забитих голів:'; cr.
    
    topScorers do: [ :athlete |
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

{ #category : 'review contracts' }
SportClub >> reviewContractsAtSpecificTime: currentTimeString [
	^ String streamContents: [ :stream |
		stream nextPutAll: 'Перегляд контрактів...'; cr.
		self reviewContracts.

		stream nextPutAll: 'Найоплачуваніший спортсмен: '; cr.
		stream nextPutAll: (self highestPaidAthlete displayInformation); cr.
	].


]

{ #category : 'as yet unclassified' }

SportClub >> saveClubToFile [ 
  | fileName file stream |
    fileName := UIManager default request: 'input name of the file to save'.
   fileName isEmpty ifTrue: [ 
       Transcript show: 'Збереження скасовано'; cr.
       ^self.
   ].

   file := FileSystem workingDirectory / fileName.
   stream := file writeStream.

   members isEmpty
        ifFalse: [
            members do: [ :athlete |
                stream nextPutAll: athlete displayInformation; cr.
            ].
        ]
        ifTrue: [
            stream nextPutAll: 'Немає членів клубу'; cr.
        ].

   stream close.
   Transcript show: 'Інформація про клуб збережена у файл: ', fileName; cr.
=======
SportClub >> showAllAthletes [ 
    Transcript show: 'Список всіх спортсменів: '; cr.
    members do: [ :athlete |
        Transcript show: athlete lastName, ', ', athlete nationality; cr.
    ].
]

{ #category : 'as yet unclassified' }
SportClub >> showTopScorers [ 
    | topScorers |
    topScorers := self findTopScorers.
    Transcript show: 'Найкращі голеадори:'; cr.
    topScorers do: [ :player | 
        Transcript show: player lastName, ', Голи: ', player goals asString; cr.
    ].
]

{ #category : 'as yet unclassified' }
SportClub >> showTopTennisPlayers [ 
    | topTennisPlayers |
    topTennisPlayers := self findTopRankedTennisPlayers.
    Transcript show: 'Тенісисти з топ-10 світового рейтингу:'; cr.
    topTennisPlayers do: [ :player | 
        Transcript show: player lastName, ', Рейтинг: ', player worldRanking asString; cr.
    ].
]

{ #category : 'as yet unclassified' }
SportClub >> someTestMethod [
    Transcript show: 'someTestMethod called'; cr.

]

{ #category : 'review contracts' }
SportClub >> startContractReviewAtSpecificTime: specificTime [
	[
		| now currentTimeString |
		[ true ] whileTrue: [
			now := Time now.
			currentTimeString := now print24.
			(currentTimeString = specificTime) ifTrue: [
				| reviewInfo |
				reviewInfo := self manualReviewContracts.
				Transcript show: reviewInfo; cr.
				(Delay forSeconds: 60) wait.
			].
			(Delay forSeconds: 10) wait.
		].
	] fork.

]

{ #category : 'as yet unclassified' }
SportClub >> topRankedTennisPlayers: aRank [ 
    ^ (members select: [ :athlete | 
        (athlete isKindOf: TennisPlayer) and: [ athlete worldRanking <= aRank ]
    ]).

]

{ #category : 'display' }
SportClub >> topRankedTennisPlayersInfo: aRank [ 
    | topTennisPlayers |
    
    topTennisPlayers := self topRankedTennisPlayers: aRank.
    
    ^ String streamContents: [ :stream |
        stream nextPutAll: 'Тенісисти з топ-', aRank asString, ' світового рейтингу:'; cr.
        
        topTennisPlayers do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
        ].
    ].

]

{ #category : 'as yet unclassified' }
SportClub >> topScorers [ 
    | sortedFootballers |

    sortedFootballers := (members select: [ :athlete | athlete isKindOf: FootballPlayer ]) copy.

    sortedFootballers sort: [ :a :b | a goalsScored > b goalsScored ].

    ^ sortedFootballers first: (3 min: sortedFootballers size).


]

{ #category : 'display' }
SportClub >> topScorersInfo [ 
    ^ String streamContents: [ :stream |
        | topScorers |
        
        topScorers := self topScorers.
        
        stream nextPutAll: 'Топ гравці за кількістю забитих голів:'; cr.
        
        topScorers do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
        ].
    ].

]

{ #category : 'accessing' }
SportClub >> totalEarnings [ 
    ^ members inject: 0 into: [ :sum :athlete | sum + athlete totalEarnings ].

]

{ #category : 'accessing' }
SportClub >> totalMembers [ 
    ^ members size.
]
