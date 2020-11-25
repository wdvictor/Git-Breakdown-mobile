# Funcionameto da API do Gitbreakdown

Link para API: https://git-breakdown-mobile.web.app



 - A api do git breakdown é dividade em 6 funcionalidades (end-points):

 1. /commits
 2. /branches
 3. /issues
 4. /ranking
 5. /pullRequest
 6. /profile

 - E contém 3 parâmetros:
	

 1. ?owner= <Usuário do Github dono do projeto>
 2. ?repository=<repositório>
 3. ?token= <Token do usuário> (Você consegue gerar token de seu usuário em configurações no Github

 - Não se esqueça de que que parâmetros precisam de um **&** entre eles. Segue um exemplo de requisição:

			https://git-breakdown-mobile.web.app/commits?owner=fga-eps-mds&repository=2019.2-Git-Breakdown&token=<token>


