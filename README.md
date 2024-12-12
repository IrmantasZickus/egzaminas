## Puslapio įjungimas

1. Terminale klonuojame darbo repozitoriją
```bash
git clone https://github.com/IrmantasZickus/egzaminas.git
```
2. Įeiname į darbo folderį
```bash
cd Darbas
```
3. Įsijungiame XAMPP Control Panel ir ant MySQL ir Apache paspaudžiame START

4. Įsijungiame MySQL Workbench, prisijungiama prie "connection", kur "Connection Name" yra "mysql", o "Username" yra "root".
Pelę užvedame ant "Server" > Data Import
Pasirenkame "Import Self Contained File" ir nurodome "duomenubaze.sql", tada apačioje dešinėje spaudžiame "Start Import". Slaptažodis turi likti tuščias.
Kairėje, ant "project" schemos, paspaudžiame dešinį klavišą ir pasirenkame "Set as Default Schema"

5. Grįžę į terminalą, parašome
```bash
npm install
```
```bash
npm run dev
```

Puslapis galimas pasiekti per [http://localhost:3000](http://localhost:3000)