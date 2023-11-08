//
//  TeamsViewModel.swift
//  SportzCric
//
//  Created by Smollan Karan on 07/11/23.
//

import Foundation
import UIKit


class TeamsViewModel: NSObject {
    // MARK: - Initiate Api call
    func getAllMatchData(success: @escaping (_ withsuccess: [Welcome]) -> Void) {
        let helper = APIHelper()
        let method = "GET"
        var allDetailsArray = [Welcome]()
        let group = DispatchGroup()
        
        let urlArr = ["https://demo.sportz.io/nzin01312019187360.json", "https://demo.sportz.io/sapk01222019186652.json"]
        if urlArr.count > 0 {
            for url in urlArr {
                group.enter()
                helper.getApiData(apiUrl: url, httpMethod: method) { success in
                    allDetailsArray.append(success)
                    group.leave()
                } failure: { errorMsg in
                    print(errorMsg)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            success(allDetailsArray)
        }
    }

    func setupCellTeamsPlayers(tableCell: UITableViewCell, player: Player) {
        if let cell = tableCell as? PlayerTableViewCell{
            var str = player.nameFull
            let position = player.position
            if let captian = player.iscaptain {
                if captian {
                    str = str + " (c)"
                }
            }
            if let keeper = player.iskeeper {
                if keeper {
                    str = str + " (wk)"
                }
            }
            cell.playerNameLabel.text = str
        }
    }
    
    func setupMatchTeamCell(tableCell: UITableViewCell, data: Welcome, vc: UIViewController) {
        if let cell = tableCell as? MatchTeamTableViewCell {
            let matchInfo = data.matchdetail.match
            let str = matchInfo.number + " " + matchInfo.date + " " + matchInfo.time
            cell.matchTypeLabel.text = str
            let teamHome = data.teams.filter({ $0.key == data.matchdetail.teamHome }).first?.value.nameShort
            let teamAway = data.teams.filter({ $0.key == data.matchdetail.teamAway }).first?.value.nameShort
            cell.teamHomeLabel.text = teamHome
            cell.teamAwayLabel.text = teamAway
            cell.tapClosure = {
                self.showMatchInfo(data: data, vc: vc)
            }
        }
    }
    
    func showMatchInfo(data: Welcome, vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let matchInfoVC = storyboard.instantiateViewController(withIdentifier: "MatchInfoViewController") as! MatchInfoViewController
        var t = [String]()
        t.append(data.matchdetail.result)
        for str in data.nuggets {
            t.append(str)
        }
        matchInfoVC.arr = t
        vc.navigationController?.present(matchInfoVC, animated: true)
    }
}
