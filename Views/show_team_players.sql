select
    player.first_name AS Name,
    player.last_name AS Nachname,
    team.name AS Team
from
    team_player
        join team on team.team_id = team_player.team_id
        join player on player.player_id = team_player.player_id
where team.name like "Informatik Kickers%"; -- Hier Team wählen