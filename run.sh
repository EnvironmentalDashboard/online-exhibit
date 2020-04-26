# add this as an option to switch to using a different path
# -e "PATH_PREFIX=online-exhibit"
docker run -dit -p 3014:4567 --restart always -v $(pwd):/usr/src/app --name glsc-exhibit online-exhibit
