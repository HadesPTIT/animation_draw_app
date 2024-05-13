echo '>>>> Start build_runner task <<<<'
fvm flutter packages pub run build_runner build --delete-conflicting-outputs
echo '>>>> Done <<<<'