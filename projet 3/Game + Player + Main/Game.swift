class Game {
    
    var allTeamsPlayer = [Player]() // Tableau (de type Player) contenant les 2 joueurs avec leur selection de personnages
    
    // Tableau (de type String) contenant l'ensemble des noms enregistrés (joueurs + personnages)
    var nameInformation = [String]()
    
    var maxPlayers = 2
    var maxCharacters = 3
    var turnNumber = 0
    var nextTeam = [1, 2]
    
    // Fonction permettant de faire fonctionner le logiciel. elle permet le lancement du jeu (après avoir instancier la class Game) étape par étape et chaque étape correspond à une fonction différente
    func start() {
        presentGame()
        createTeamPlayer()
        recapitulatesTeams()
        battleRoundByRound()
        statistics()
    }
    
    func presentGame() { // fonction comprenant la 1er partie du jeu. C'est une introduction au jeu
        print("")
        print("""
            ⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛ 🛡️  WAR OF HERES 🛡️ ⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛
            
            Ceci est un jeu de combat à 2 joueurs dont l'action se déroule au tour par
            tour. Chacun des joueurs doit constituer une équipe de 3 personnages afin
            de démarrer la partie.
                                                                                        
            Au cour du jeu, un coffre apparaîtra de manière alléatoire et permettra à
            l'un des joueurs d'obtenir une nouvelle arme !
                                                                                        
            La partie prend fin lorsque tous les personnages d'une équipe sont morts..
            A présent, préparez-vous à combattre et que le meilleur gagne ! 🤝
                                                                                        
            ⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛
            """)
    }
    // fonction comprenant la 2ème partie du jeu. Elle permet la constitution des équipes de chaque joueur
    func createTeamPlayer() {
        for n in 0..<maxPlayers { // on lance une boucle sur la base de nos 2 joueurs
            print("\n➡️  PLAYER \(n + 1) 🎮") // à chaque tour de boucle, on ajoute un joueur
            
            // cette constante permet de récupérer la sélection des personnages des 2 joueurs. Chaque selection est contenu dans un tableau différent
            if let teams = createTeamCharacter() {
                
                // Les 2 joueurs enregistrés ainsi que leur selection respective sont ajoutés au tableau "allTeamsPlayer"
                allTeamsPlayer.append(teams)
                
                teams.displayCharactersTeam() // on affiche les informations des personnages selectionnés pour chaque jours
            }
        }
    }
    
    // fonction créant un tableau pour chaque selection de chaque joueur à destination du tableau allTeams par le renvoi de "player?"
    func createTeamCharacter() -> Player? {
        
        // playerName de la class "Player" permet d'attribuer un nom à chaque joueur grace à l'init "getNamePlayer" de celle-ci
        let playerName = Player(getNamePlayer: choisePlayerName())
        
        // constante permettant de récuper les personnages selectionnés par le joueur. Cette selection se trouve dans un tableau provisoire (de type "[Character]") de la fonction "compositionTeam". "team" hérite donc du type [Character]
       if let team = composeTeam() {
        
        // allTeams appartient à la class Player. playerName étantd de type "Player" nous permet l'accès au tableau "allTeams" afin d'y ajouter la selection du joueur par le biais de la constante "team". "team" et "allTeams" sont tous deux des tableaux de type [Character]
        playerName.allTeams += team
        }
        return playerName // renvoi d'un type Player
    }

    func choiceUniqueName() -> String { // fonction complémentaire pour les fonctions nom "Player" et nom "Personnage"
        var identity = ""
        repeat {
            if let choise = readLine() {
                identity = choise.lowercased()
                
            if nameInformation.contains(identity) {
                        print("Ce nom est déjà utilisé ! ✋⛔🤚")
                        identity = ""
                    } else {
                    nameInformation.append(identity)
                }
            }
            } while identity == ""
        return identity
    }
    
    func choiceCharacterName() -> String { // fonction pour créer un nom de personnage
        print("")
        print("🦹 Indiquez le nom de votre personnage :")
        let choiceCharacterName = choiceUniqueName()
        return choiceCharacterName
    }
    
    func choisePlayerName() -> String { // fonction pour créer un nom de joueur
        print("")
        print("✍️ Entrer votre nom de joueur :")
 
        let choicePlayerName = choiceUniqueName()
        return choicePlayerName
    }
    
    // fonction permettant à chaque joueur de selectionner des personnages pour constituer leur équipe
        func selectTeam() -> Character? {
            var userChoice = 0
            print("")
            print("composer votre équipe en choisissant 3 personnages"
                
                + "\n"
                + "\n1. 🧲 Warrior - ❤️  250 - 🤜💥 10"
                + "\n———————————————————————————————–––"
                + "\n2. 🗡 Knight  - ❤️  150 - 🤜💥 30"
                + "\n————————————————————————————————––"
                + "\n3. 🏹 Elf     - ❤️  225 - 🤜💥 15"
                + "\n————————————————————————————————––"
                + "\n4. 💣 Fighter - ❤️  175 - 🤜💥 25"
                + "\n————————————————————————————————––"
                + "\n5. 🦯 Mage    - ❤️  150 - 🤜💥 40"
                + "\n————————————————————————————————––"
                + "\n6. 🪓 Peasant - ❤️  200 - 🤜💥 20"
                + "\n————————————————————————————————––")
            
            while userChoice != 1 && userChoice != 2 && userChoice != 3 && userChoice != 4 && userChoice != 5 && userChoice != 6 {
                if let information = readLine() { // Permet d'entrer les informations du joueur
                if let informationInt = Int(information) {
                    userChoice = informationInt
                } else {
                    print("Reponse non valide.")
                    print("Vous devez entrer un nombre entre 1 et 6 afin de valider votre choix")
                    }
                }
            }

                switch userChoice {
                case 1:
                    let warrior = Warrior(name: choiceCharacterName())
                    print("")
                    print("🧲 \(warrior.name) au boomerang a été ajouté 🔵")
                    return warrior
                case 2:
                    let knight = Knight(name: choiceCharacterName())
                    print("")
                    print("🗡  \(knight.name) à l'épée a été ajouté 🟢")
                    return knight
                case 3:
                    let elf = Elf(name: choiceCharacterName())
                    print("")
                    print("🏹 \(elf.name) à l'arbalète a été ajouté 🟠")
                    return elf
                case 4:
                    let fighter = Fighter(name: choiceCharacterName())
                    print("")
                    print("💣 \(fighter.name) aux bombes a été ajouté 🟣")
                    return fighter
                case 5:
                    let mage = Mage(name: choiceCharacterName())
                    print("")
                    print("🦯 \(mage.name) au baton a été ajouté 🟤")
                    return mage
                case 6:
                    let peasant = Peasant(name: choiceCharacterName())
                    print("")
                    print("🪓 \(peasant.name) à la hache a été ajouté 🔴")
                    return peasant
                    
                    default:
                    return nil
                }
                }
    
    // fonction permettant de receptionné les personnages choisis par le joueur. Les données (de type "Character") seront intégrés dans un tableau de type [Character]
    func composeTeam() -> [Character]? {
        
        var team = [Character]() // tableau provisoire pour receptionner les données du joueur
        
        for selection in 0..<maxCharacters { // sélection de 3 personnages
            
            // constante servant à exploiter les données de la fonction selectTeam afin de les transférer dans un tableau
            if let selection = selectTeam() {
                team.append(selection) // données transférer dans le tableau provisoire

            }
            if selection == 0 {
                print("Il vous reste encore 2 personnages à choisir")
                       }
            if selection == 1 {
                print("Il vous reste encore 1 personnage à choisir")
                       }
            if selection == 2 {
                print("")
                print("⏬ Votre équipe est maintenant au complet ⏬")
                print("")
            }
        }
        return team
    }

    
    func presentNextTeam() {
        nextTeam.swapAt(0, 1)
        print("👤 C'est au tour de l'équipe \(nextTeam[0])")

        }
    
    func recapitulatesTeams() { // récapitulatif des 2 équipes au complet
        print("")
        print("\n🔥 VOICI LES 2 EQUIPES QUI VONT S'AFFRONTER 🔥")
        print("")
        print("")
        print("🐲 EQUIPE JOUEUR 1")
            allTeamsPlayer[0].displayCharactersTeam()
        print("")
        print("")
        print("🐲 EQUIPE JOUEUR 2")
            allTeamsPlayer[1].displayCharactersTeam()
        print("")
    }
    
    func changeTeamsPlayer() { // fonction permettant de changer d'équipe
        allTeamsPlayer.swapAt(0, 1)
        
    }
                
    // fonction pour choisir le personnage de son équipe (pour joueur et soigner) ainsi que le personnage de l'équipe adversaire (pour attaquer)
    func selectCharacterPlayer() -> Character {
        
        var choiceCharacterPlayer: Character?
        var choicePlayer = 0
            while choicePlayer != 1 && choicePlayer != 2 && choicePlayer != 3 && choicePlayer != 4 && choicePlayer != 5 && choicePlayer != 6 {
                if let information = readLine() { // Permet d'entrer les informations du joueur
                if let informationInt = Int(information) {
                    choicePlayer = informationInt
                } else {
                    print("Reponse non valide.")
                    print("Vous devez entrer un nombre entre 1 et 3 afin de valider votre choix")
                    }
                }
            }
                switch choicePlayer {
                case 1:
                choiceCharacterPlayer = allTeamsPlayer[0].allTeams[0]
                case 2:
                choiceCharacterPlayer = allTeamsPlayer[0].allTeams[1]
                case 3:
                choiceCharacterPlayer = allTeamsPlayer[0].allTeams[2]
                default:
                    break
                }
                if let choiceCharacter = choiceCharacterPlayer {
                    if choiceCharacter.hp == 0 {
                        print("""
                        Ce personnage est mort ! 💀
                        Choisissez un autre équipier..
                        """)
                        _ = selectCharacterPlayer()
                    }
                }
        return choiceCharacterPlayer!
    }

    func appearSafe() -> Bool { // fonction permettant de déclencher l'apparition d'un coffre contenant deux armes spéciales
        var appearSafe = true
        let getSafe = Int.random(in: 1...6)
        if getSafe == 3 {
            appearSafe = false
            print("")
            print("Vous avez trouvez un coffre ! 🎁")
            print("choisissez une nouvelle capacité ⭐"
                
                + "\n"
                + "\n1. Utiliser la super potion 🧪 - ❤️ 100"
                + "\n———————————————————————————————–––————"
                + "\n2. Foudroyer votre adversaire ⚡ - 💥 100"
                + "\n————————————————————————————————––——————")
            
        } else {
            
            print("Que voulez-vous faire 🤔"
            
                + "\n"
                + "\n1. Soigner un équipier ❤️"
                + "\n——————————————————————————————"
                + "\n2. Attaquer le camp adverse ⚔️"
                + "\n——————————————————————————————")
            
                    }
                    return appearSafe
            }

    
    func battleRoundByRound() { // fonction permettant l'interraction entre les 2 équipes au tour par tour
        
        print("PREPAREZ-VOUS A COMBATTRE !!! 👊")
        print("🐲 EQUIPE 1 commence la partie ☝️ A la fin de l'action, c'est au tour de 🐲 EQUIPE 2 de jouer ✌️")
        print("Le jeu se déroule au tour par tour 🔄 et prends fin lorsqu'une des 2 équipes meurt ☠️ ")
        print("")
        repeat {
        allTeamsPlayer[0].displayCharactersTeam()
        print("")
        print("CHOISISSEZ UN COMBATTANT DANS VOTRE EQUIPE (👉 Saisissez le chiffre 1️⃣,2️⃣ ou 3️⃣ 👈)")
        let choiceCharacterPlayer = selectCharacterPlayer()
            let attackOrHealSuper = appearSafe()
        var userChoice = 0
        while userChoice != 1 && userChoice != 2 {
            if let information = readLine() { // Permet d'entrer les informations du joueur
            if let informationInt = Int(information) {
                userChoice = informationInt
            } else {
                print("Reponse non valide.")
                print("Vous devez entrer le nombre 1 ou 2 pour valider votre choix")
                }
            }
        }
            switch userChoice {
            case 1:
                allTeamsPlayer[0].displayCharactersTeam()
                print("Choisissez l'équipier que vous désirez soigner 🤕 (👉 Saisissez le chiffre 1️⃣,2️⃣ ou 3️⃣ 👈)")
                if attackOrHealSuper == true {
                let healCharacter = selectCharacterPlayer()
                    print("Votre équipier à bien été soigné 👌🤗")
                    print("")
                choiceCharacterPlayer.care(restore: healCharacter)
                    turnNumber += 1
                    changeTeamsPlayer()
                    print("Nombre de tours: \(turnNumber)")
                    print("")
                    presentNextTeam()
                    print("")
                } else if attackOrHealSuper == false {
                    let healCharacter = selectCharacterPlayer()
                    print("Votre équipier est comme neuf ✌️😎")
                    print("")
                    choiceCharacterPlayer.superCare(restore: healCharacter)
                turnNumber += 1
                print("Nombre de tours: \(turnNumber)")
                    print("")
                    presentNextTeam()
                print("")
                }
            case 2:
                allTeamsPlayer[1].displayCharactersTeam()
                print("Choisissez votre adversaire ⚠️ (👉 Saisissez le chiffre 1️⃣,2️⃣ ou 3️⃣ 👈)")
                changeTeamsPlayer()
                    if attackOrHealSuper == true {
                        let attackCharacterOpposing = selectCharacterPlayer()
                        print("💫💥💥 🤮‼️")
                        print("Votre adversaire est touché 😫")
                choiceCharacterPlayer.hitPoint(damage: attackCharacterOpposing)
                choiceCharacterPlayer.increaseCare(increase: choiceCharacterPlayer)
                        turnNumber += 1
                        print("Nombre de tours: \(turnNumber)")
                        print("")
                        presentNextTeam()
                        print("")
                    } else if attackOrHealSuper == false {
                        let attackCharacterOpposing = selectCharacterPlayer()
                        print("💫💥💥💥💥 🤮‼️")
                        print("Superbe attaque ‼️ 😵")
                        choiceCharacterPlayer.superHitPoint(damage: attackCharacterOpposing)
                        choiceCharacterPlayer.increaseCare(increase: choiceCharacterPlayer)
                turnNumber += 1
                print("Nombre de tours: \(turnNumber)")
                        print("")
                        presentNextTeam()
                print("")
                }
            default:
                break
            }

            } while finishTheGame()

            }
    
    
    func finishTheGame() -> Bool { // fonction mettant fin à la partie lorsqu'une des 2 équipes à perdu
        let killTeam = false
        for i in 0..<allTeamsPlayer.count {
            let team1 = allTeamsPlayer[i]
            let team2 = allTeamsPlayer[i+1]
            if team1.isDead() {
                winMessage(teamName: team2.getNamePlayer)
                return killTeam == true
            } else if team2.isDead() {
                winMessage(teamName: team1.getNamePlayer)
                return killTeam == true
            } else {
                return killTeam == false
            }
        }
        return killTeam
    }
    
    func winMessage(teamName: String) { // fonction emettant un message à l'équipe gagnante
        print("Victoire à l'équipe \(teamName), congratulation ✨👑✨")
    }
    func statistics() { // fonction affichant les statistiques du jeu à la fin de la partie
        print(""
            + "\n————————————————————————————————––————"
            + "\n - Nombre de tours dans le jeu : \(turnNumber)"
            + "\n————————————————————————————————––————"
            + "\n - Liste des personnages des 2 équipes"
            + "\n————————————————————————————————––————"
            + "\n")
        allTeamsPlayer[0].displayCharactersTeam()
        allTeamsPlayer[1].displayCharactersTeam()

    }
}
