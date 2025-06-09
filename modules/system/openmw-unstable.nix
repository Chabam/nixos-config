{
  qt6Packages,
  inputs,
  ...
}:

qt6Packages.callPackage
  (
    {
      SDL2,
      boost,
      bullet,
      cmake,
      fetchFromGitHub,
      fetchFromGitLab,
      fetchurl,
      ffmpeg,
      libxml2,
      luajit,
      lz4,
      minizip,
      mygui,
      openal,
      openscenegraph,
      pkg-config,
      qt6,
      readline,
      recastnavigation,
      stdenv,
      unshield,
      wrapQtAppsHook,
      xorg,
      yaml-cpp,
      lib,
      ...
    }:

    let
      inherit (lib) optionals;

      GL = "GLVND";

      collada-dom = stdenv.mkDerivation {
        pname = "collada-dom";
        version = "master";

        src = fetchFromGitHub {
          owner = "rdiankov";
          repo = "collada-dom";
          rev = "c1e20b7d6ff806237030fe82f126cb86d661f063";
          sha256 = "A1ne/D6S0shwCzb9spd1MoSt/238HWA8dvgd+DC9cXc=";
        };

        patches = [
          (fetchurl {
            url = "https://aur.archlinux.org/cgit/aur.git/plain/fix-compatibility-with-boost-1.85.patch?h=collada-dom";
            hash = "sha256-z6sC8ASLRe6lkobR0FTbLl176upnXNKyITDKyVVxOVU=";
          })
        ];

        postInstall = ''
          chmod +w -R $out
          mv $out/include/*/* $out/include
        '';

        nativeBuildInputs = [ cmake ];

        buildInputs = [
          boost
          libxml2
          minizip
          readline
        ];
      };

      osg' = (openscenegraph.override { colladaSupport = true; }).overrideDerivation (old: {
        COLLADA_DIR = collada-dom;
        cmakeFlags =
          (old.cmakeFlags or [ ])
          ++ [
            "-Wno-dev"
            "-DOpenGL_GL_PREFERENCE=${GL}"
            "-DBUILD_OSG_PLUGINS_BY_DEFAULT=0"
            "-DBUILD_OSG_DEPRECATED_SERIALIZERS=0"
          ]
          ++ (map (e: "-DBUILD_OSG_PLUGIN_${e}=1") [
            "BMP"
            "DAE"
            "DDS"
            "FREETYPE"
            "JPEG"
            "OSG"
            "PNG"
            "TGA"
          ]);
      });

      bullet' = bullet.overrideDerivation (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-Wno-dev"
          "-DOpenGL_GL_PREFERENCE=${GL}"
          "-DUSE_DOUBLE_PRECISION=ON"
          "-DBULLET2_MULTITHREADING=ON"
        ];
      });

      mygui' = mygui.overrideDerivation (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DMYGUI_DONT_USE_OBSOLETE=ON"
        ];
      });

    in
    stdenv.mkDerivation {
      pname = "openmw-unstable";
      version = "openmw-0.48.0-unstable-2025-05-30";

      src = fetchFromGitLab {
        owner = "OpenMW";
        repo = "openmw";
        rev = "0c6c71f6cb5045b2e17bfa41719e39498ef047e2";
        hash = "sha256-fuRexQt0zFhv1ths0iBdPZSKMqpPU4dU6PDAmUVJOPg=";
      };

      nativeBuildInputs = [
        cmake
        pkg-config
        wrapQtAppsHook
      ];

      buildInputs = [
        SDL2
        boost
        bullet'
        ffmpeg
        luajit
        lz4
        mygui'
        openal
        osg'
        qt6.full
        qt6.qtbase
        recastnavigation
        unshield
        xorg.libXt
        yaml-cpp
      ];

      cmakeFlags = [
        "-DOpenGL_GL_PREFERENCE=${GL}"
        "-DOPENMW_USE_SYSTEM_RECASTNAVIGATION=1"
      ];
    }
  )
  {
    inputs = inputs;
  }
