This is a docker version of the https://github.com/DottoreTozzi/iSpindel-TCP-Server project that currently runs only on armhf (pi's)

This container will start the python script and then do whatever you tell the script to do. In the future I will work on making other containers to work with this for db and the webui from the original project (although I suspect that will be tweaks to other containers anyway). If you want to write to csv or forward onto other services I believe this will just work as it is now. But I have only been anle to test the csv part as I don't use the others.

The locations have a changed a little (iSpindel or iSpindle...) but you should be able to work with it as is.

You will need to create a folder with the iSpindle.py file in with the settings you want. The basic with writing to csv can be found here https://github.com/charliwest/iSpindel-TCP-Server/blob/master/iSpindle.py (turns off mysql and places the csv in the correct location for docker).

Then you can create the container. For this you should pass the variables of the location of your storage. 

Example
```
docker create --restart=always --name=ispindle -v /storage/ispindle:/config/ispindle -e PUID=1010 -e PGID=1010 -p 9501:9501 -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime charliwest/ispindel-service
```

Now point the iSpindel as you would have previously but to your docker's IP address.

Please note I have only tested this a little, if you want to use it don't blame me if it falls over mid ferment ;)

If anyone using craftbeer etc could test it and let me know if it's working with them as well that would be great.
