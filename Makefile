#
# Makefile
# uralbash, 2017-09-15 16:57
#

all:
	cd ../ \
		&& make clean \
		&& nix-shell ./_lectures/default.nix \
		--indirect --add-root .gcroots/dep \
		--run "make html test"

clean:
	cd ../ && make clean

nix-shell:
	nix-shell . --indirect --add-root .gcroots/dep

cp-github:
	cp -r ./github/* ../

update-git-submodule: cp-github
	git pull
	cd ../ && \
		git add . && \
		git commit -m "update submodule" && \
		git push

# vim:ft=make
#
