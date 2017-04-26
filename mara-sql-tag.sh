#!/bin/bash

. ./sql-base.sh
. ./sql-tag-base.sh

SQL_MODULE=/SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/AddMaRaContactReasonTag
REVISION=520

#MM/DD/YYYY HH:MI:SS AM
DATE="04/21/2017"



declare -a DISPLAY_NAMES=('MaRa Contact Reasons' 
					'['
					   'Asiakas'
					   '[' 
						'Uusi varaus'
						'Verma-varaus'
						'Varauksen muutos'
						'Peruutus'
						'Internettuki'
						'Joku muu/ Muu asiakkaan neuvonta'
						'Ennakkolasku'
						'Myöhäisen tuloajan ilmoitus'
						'Nettikampanja  (Black Friday tms)'
						'Reklamaatio'
						'Tarjouspyyntö/hintatiedustelu'
						'Spam/Out of office/Ei tarvitse vastata'
						'Laskutuslupakysely'
						'Pöytävaraus'
						'Ryhmä-, kokous tai ravintolapuhelu'
						'Reconfirmation'
					    ']' 
                                            'Myyntipäällikkö'
					    '['
						'Uusi varauspyyntö'
						'Muutos olemassa olevaan varaukseen'
						'Peruutus'
						'Neuvontaa'
						'Tarkistus tiedetäänkö ajankohtaisista kamppiksista ym'
						'Spam/Out of office/Ei tarvitse vastata'
						'Joku muu'
					    ']'
					    'Yksikkö'
					    '['
						'Soitto mypan soittopyynnön perään'
						'Menneen tai tulevan varauksen selvityspyyntö'
						'Uusi varaus'
						'Muutos olemassa olevaan varaukseen'
						'Peruutus'
						'Reklamaatio'
						'Joku muu'
					    ']'
					    'PK/TRE mypa'
					    '['
						'Aiheellinen kysely'
						'Aiheeton kysely (itse olisi voinut hoitaa)'
					    ']'
					    'Tukihenkilö'
					    '['
					    	'Avunpyyntö'
					    	'Selvitys'
					    	'Reklamaatio'
					    ']'
					    'Esimies'
					    '['
					    	'Selvitys'
					    	'Reklamaatio'
					    ']'
					 ']')
SQL=$(generate_tag $1)
echo "$SQL"
create_sql_module $SQL_MODULE $REVISION "$SQL"

