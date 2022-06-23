tabulador="	"
exp_name=ZZ8420B
echo "experiment	timestamp	event"  >  log.txt 
fecha0=$(date +"%Y%m%d %H%M%S") 
echo "$exp_name""$tabulador""$fecha0""$tabulador""SH_START" >> log.txt 
Rscript --vanilla ~/labo/src/lib/exp_run_init.r  ZZ8420B
Rscript --vanilla ~/labo/src/completo/z999_ZZ_lightgbm_semillerio.r  ZZ8420B  2>&1 | tee outfile 
Rscript --vanilla ~/labo/src/lib/exp_run_end.r
fecha1=$(date +"%Y%m%d %H%M%S") 
echo "$exp_name""$tabulador""$fecha1""$tabulador""SH_END" >> log.txt 
cp  ~/log/*.txt  ./  
find ./ ! -name "*.gz" ! -name . -exec cp -prt /media/expshared/balzarini_bianca/exp/ZZ8420B/  {} +  

#suicidio
export NAME=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google') 
export ZONE=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google') 
gcloud --quiet compute instances delete $NAME --zone=$ZONE 
