#
# Makefile
# uralbash, 2017-09-15 16:57
#


nix-shell:
	nix-shell . --indirect --add-root .gcroots/dep

cp-github:
	cp -r ./github/* ../

update-git-submodule:
	git pull
	cd ../ && \
		git add . && \
		git commit -m "update submodule" && \
		git push

# vim:ft=make
#
