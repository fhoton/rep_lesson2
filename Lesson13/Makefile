Server:
	docker run --name teamcity-server-instance -v /home/alex/teamcity/TM_server:/data/teamcity_server/datadir -v /home/alex/teamcity/TM_logs:/opt/teamcity/logs -p 8111:8111 jetbrains/teamcity-server

Agent: 
	docker run -e SERVER_URL="192.168.1.115:8111"  -v /home/alex/teamcity/TM_agent:/data/teamcity_agent/conf jetbrains/teamcity-agent