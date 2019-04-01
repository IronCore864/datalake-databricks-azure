.PHONY: clean setup 
all: clean setup

clean:
	rm -rf install-databricks
	rm -rf install-datalake
	rm -rf databricks-parameters.json

setup:
	pip install --upgrade pip
	pip install -r requirements.txt

deployDev:
	./make --env dev
	chmod +x install-datalake
	chmod +x install-databricks
	./install-datalake
	./install-databricks
	
deployProd:
	./make --env prod
	chmod +x install-datalake
	chmod +x install-databricks
	./install-datalake
	./install-databricks
