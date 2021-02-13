CREATE DATABASE IF NOT EXISTS `AssetManagement` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `AssetManagement`;


drop table if exists Article;
drop table if exists Asset;
drop table if exists AssetType;
drop table if exists Category;
drop table if exists Employee;
drop table if exists NewAssetRequest;
drop table if exists RecommendedArticles;
drop table if exists Reply;
drop table if exists SupportTicket;


CREATE TABLE "Article" (
	"ARTID"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"Title"	TEXT,
	"ArtCont"	TEXT,
	"CID"	INTEGER,
	FOREIGN KEY("CID") REFERENCES "Category"("CID")
);

CREATE TABLE "Asset" (
	"AID"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"DateOfIssue"	TEXT,
	"ExpiresOn"	TEXT,
	"EID"	INTEGER,
	"ATID"	TEXT,
	FOREIGN KEY("EID") REFERENCES "Employee"("EID"),
	FOREIGN KEY("ATID") REFERENCES "AssetType"("ATID")
);

CREATE TABLE "AssetType" (
	"ATID"	TEXT,
	"AvailableQuantity"	INTEGER,
	"ApprovalNeeded"	TEXT,
	"ATDescription"	TEXT,
	"ImageUrl"	TEXT,
	PRIMARY KEY("ATID")
);

CREATE TABLE "Category" (
	"CID"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"CName"	TEXT,
	"CDescription"	TEXT
);


CREATE TABLE "Employee" (
	"EID"	INTEGER,
	"Name"	TEXT,
	"Team"	TEXT,
	"DOJ"	TEXT,
	"Password"	TEXT,
	"Admin"	TEXT,
	PRIMARY KEY("EID")
);





INSERT INTO `Article` (`ARTID`, `Title`, `ArtCont`, `CID`) VALUES
('1', 'Do more on the desktop', 'Stacks cleans up a cluttered desktop by automatically organising the files on your desktop into related groups. Just click the desktop, then choose View > Use Stacks. Every time you add a file on the desktop, it goes into the right stack.', '4'),
('2', 'Work on files without opening an app', 'Right from the desktop, you can rotate, crop, sign and mark-up images and PDFs — even trim audio and video files — all without opening an app. Simply select a file, press the Space bar, then click the Markup icon.', '4'),
('3', 'How to free up storage space on your Mac', 'Optimized Storage in macOS Sierra and later can save space by storing your content in the cloud and making it available on demand. When storage space is needed, files, photos, movies, email attachments, and other files that you seldom use are stored in the cloud automatically. Each file stays right where you last saved it, and downloads when you open it. Files that you’ve used recently remain on your Mac, along with optimized versions of your photos.', '3'),
('4', 'Update your device using iTunes', 'If you can’t update wirelessly on your iOS device, you can update manually using iTunes on a computer that you trust. If your computer is using Personal Hotspot on the iOS device that you’re updating, connect your computer to a different Wi-Fi or Ethernet network before you update.', '3'),
('5', 'What version of the MacOS is pre-installed on the MacBook?', 'For the maximum supported version of MacOS X for all "recent" -- G3 and later -- Macs, please refer to the Maximum Supported MacOS listing.', '1'),
('6', 'Can the MacBook run MacOS 9/Classic applications?', 'Apple provides no support for running MacOS 9 or the "Classic Environment" on Intel-based Macs like the MacBook. The MacBook relies on the "Rosetta Universal Binary Translator" to run software for MacOS X for PowerPC, and this emulator cannot run "Classic/MacOS 9" applications.', '1'),
('7', 'How does the "MagSafe" power connector on the MacBook work? How is the MagSafe power connector designed to not cause data loss?', 'The MagSafe Power Adapter is just that: a magnetic connection instead of a physical one. So tripping over a power cord wont send your shiny new MacBook flying off a table or desk; the cord simply breaks cleanly away, without damage to either the cord or the system. As an added nicety, this means less wear on the connectors.', '1'),
('8', 'Reset the PRAM and SMC', 'The parameter random-access memory (PRAM) and system management controller (SMC) are in charge of a lot of important things on your computer (for a list of things, check out this article on resetting the PRAM and SMC). To', '2'),
('9', ' Diagnose the Problem', 'If you’re still seeing the problem, you’ll need to figure out what’s causing it. The first thing to do is figure out if you’re having a hardware- or software-related issue. To check your hardware, fire up Apple Diagnostics', '2'),
('10', 'Shake window to minimise', 'This is one of my personal favourites. If you click and drag a window, you can then give it a little shake - go on, try it! All the other windows you have open will instantly minimise, giving you a clutter free workspace.', '4'),
('11', 'Forget CTRL+ALT+DEL', 'Most people will press CTRL+ALT+DEL when their computer crashes, and then instantly open the task manager. Instead, try hitting CTRL+Shift+ESC to open the task manager directly. After all, if your computer\s crashing, the fewer steps in the process the better. You can of course open the task manager by right-clicking on the task bar, but this method has a bit more of a sleight of hand feeling to it.', '4'),
('12', 'God mode', 'The Windows Master Control Panel, or "God Mode", is a shortcut to access all of the operating system\s control panels from within a single folder. To create a such a shortcut, create a new folder on your desktop (or anywhere else) and rename it to:You can change the "GodMode" bit, but make sure the full-stop and the rest is the same. Once you\ve renamed it, the icon will change, and you\ll have access to all Windows\ most powerful features.', '4'),
('13', 'Set up', 'Thin Client allows you to access a Windows environment remotely from a computer. It enables you to have access to the University Server as well as a wide variety of software that you would otherwise not be able to use unless it was physically loaded onto your computer. You access Thin Client from either your workstation or a Macintosh Computer', '3'),
('14', 'Website Not Loading', 'If the problem is a specific website not loading, you can check downforeveryoneorjustme.com to see if you\re the only one having the issue with the website — or you can often do a quick search on Twitter to see if other people are complaining as well.', '2'),
('15', 'Slow Response Times', 'Sometimes the problem isn\t connecting to the internet, but slow response times while you\re browsing — or maybe your browser is simply hanging. If you\re using Internet Explorer, you can reset all your settings to fix problems; if you\re using Firefox you can follow this guide to troubleshoot problems or just completely restore the default settings.', '2'),
('16', 'Dealing With a Forgotten Password', 'While forgetting a password might not technically be a troubleshooting problem, it\s a common problem that needs to be solved. Your best best is to try to recover your passwords using free tools to crack your existing passwords. If you\ve got an Ubuntu Live CD laying around, you can use that to reset your password, or if you want a more streamlined Linux-based Live CD and youre not afraid of some command-line action, you can use the System Rescue CD to reset your Windows password in no time at all.', '2'),
('17', 'Merge Layers to a New Layer', 'More often than not, as I\m working in Photoshop I\ll end up with tons and tons of layers. Occasionally, I\ll need to merge all those layers into a single layer. To do that and retain the integrity of the layer structure, press Command/Control + Shift + Alt/Option + E. With that simple keystroke, all your layers will save and merge, and a new layer will appear. Easy huh?', '4'),
('18', 'Change Layer Opacity', 'Photoshop CC has a hotkey to adjust layer opacity, which is found by selecting the Move Tool and pressing a number on the keyboard.', '3'),
('19', ' Start using document styles', 'If you need to create a lot of documents similar in nature, you should use styles. Once you create a style template, you can use it again for another similar document. If you write a lot of letters, you can create a letter style, and it will save you a lot of time.', '4'),
('20', 'Modify your paste command', 'Have you ever tried pasting some text and discovered that it lost all formatting that it was supposed to carry? Well, you can actually configure how the paste option works on MS Word. Just go to Office button, navigate to Word Options, and go to advanced. There, you\ll see a Cut, Copy, Paste option where you can make the changes. ', '3');




INSERT INTO `Employee` (`EID`, `Name`, `Team`, `DOJ`) VALUES

('4', 'Ansh', 'PM', '04/05/17'),
('5', 'Sanskruti', 'Sales ', '05/05/18'),
('6', 'Darshana', 'Marketing', '06/05/12'),
('7', 'Ash', 'Support ', '07/05/14'),
('8', 'Mallika', 'PM', '08/05/19'),
('9', 'Erica', 'Sales ', '09/05/15'),
('10', 'Yohan', 'Support ', '06/05/15'),
('11', 'Kartik', 'PM', '07/05/16'),
('12', 'Ritu', 'Marketing', '08/05/15'),
('13', 'Kirti', 'PM', '09/05/15'),
('14', 'Ali', 'Sales ', '01/05/10'),
('15', 'Robert', 'PM', '02/05/01'),
('16', 'Asra', 'Marketing', '03/05/03'),
('17', 'Emma', 'Sales ', '04/05/11'),
('18', 'Andrew', 'PM', '05/05/15'),
('19', 'Christie', 'Marketing', '06/05/01'),
('20', 'Nick', 'PM', '07/05/02'),
('21', 'Jessie', 'Sales ', '08/05/03'),
('22', 'James', 'Marketing', '09/05/05'),
('23', 'Anita', 'Support ', '06/05/06'),
('24', 'Bernie', 'Support ', '07/05/00'),
('25', 'Monty', 'PM', '08/05/00')



INSERT INTO `AssetType` (`ATID`, `AvailableQuantity`, `ApprovalNeeded`, `ATDescription`, `ImageUrl`) VALUES
('Apple Macbook Air', '20', 'No', 'Apple Macbook Air', 'https://www.jbhifi.com.au/FileLibrary/ProductResources/Images/267431-L-LO.jpg'),
('MS Office ', '89', 'No', 'Office 365 is a cloud-based subscription service that brings together the best tools for the way people work today.', 'https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiD4s6OjLTiAhUUfH0KHXZlD2sQjRx6BAgBEAU&url=https%3A%2F%2Fwww.indiamart.com%2Fproddetail%2Fms-office-15703795830.html&psig=AOvVaw1mUVmGDjyyfp_rNsZLpdz4&ust=1558784822319986'),
('Adobe photoshop', '25', 'No', 'Used for photoshop requirements', 'https://cdn.vox-cdn.com/thumbor/vNGNxVAhztPIMvpecZETrPvBXfw=/30x0:990x640/1200x800/filters:focal(30x0:990x640)/cdn.vox-cdn.com/assets/2805141/photoshop.png'),
('Apple iMac', '12', 'No', 'Now everyone from video editors to 3D animators to musicians and software developers can turn big ideas into amazing work like never before. iMac Pro is powered by an Intel Xeon W processor with 8 cores for incredible performance. Its Radeon Pro Vega graphics chip lets you build and render amazingly lifelike special effects and VR worlds. And with 32GB of memory and 1TB of flash storage, projects load and save almost instantly. Introducing iMac Pro, the most powerful Mac ever.', 'https://www.jbhifi.com.au/FileLibrary/ProductResources/Images/264382-L-LO.jpg'),
('Mac OS X', '12', 'No', 'is a series of graphical operating systems developed and marketed by Apple Inc. since 2001. It is the primary operating system for Apple\ Mac family of computers', 'https://tr1.cbsistatic.com/hub/i/r/2017/12/11/9fac1c13-984f-429c-83a8-1a7a286271ae/resize/1200x/3a6056002ad89cefbd930cd12fb78e0b/macoshero.jpg'),
('Windows 7', '200', 'No', 'Window 7', 'https://images-na.ssl-images-amazon.com/images/I/51EOtSLH%2B8L._AC_UL320_SR256,320_.jpg'),
('Dell XPS 13 Laptop', '5', 'No', 'Suitable for developers working on development tools', 'https://i.dell.com/das/xa.ashx/global-site-design%20web/00000000-0000-0000-0000-000000000000/1/LargePNG?id=Dell/Product_Images/Dell_Client_Products/Notebooks/XPS_Notebooks/XPS_13_9350_Non_Touch/global_spi/laptop-xps-13-9350-non-touch-silver-right-hero-504x350.psd');


INSERT INTO `NewAssetRequest` (`NARID`, `EID`, `ATID`, `ApprovalStatus`, `NARStatus`) VALUES
('1', '25', 'MS Office', 'TRUE', 'Accepted'),
('2', '24', 'Windows 7', 'FALSE', 'Accepted'),
('3', '23', 'Apple Macbook Air', 'FALSE', 'Accepted'),
('4', '22', 'Apple iMac', 'TRUE', 'Accepted'),
('5', '21', 'Adobe photoshop', 'FALSE', 'Accepted'),
('6', '20', 'Windows 7', 'TRUE', 'Accepted'),
('7', '1', 'Apple Macbook Air', 'FALSE', 'Accepted'),
('8', '2', 'Apple iMac', 'TRUE', 'Accepted'),
('9', '3', 'Adobe photoshop', 'FALSE', 'Accepted'),
('10', '4', 'Windows 7', 'TRUE', 'Accepted'),
('11', '5', 'MS Office', 'FALSE', 'Accepted'),
('12', '19', 'Apple iMac', 'FALSE', 'Accepted'),
('13', '18', 'MS Office', 'TRUE', 'Accepted'),
('14', '17', 'Mac OS X', 'FALSE', 'Accepted'),
('15', '16', 'Apple Macbook Air', 'FALSE', 'Accepted'),
('16', '15', 'Apple Macbook Air', 'TRUE', 'Accepted'),
('17', '14', 'Mac OS X', 'FALSE', 'Accepted'),
('18', '13', 'Apple iMac', 'TRUE', 'Accepted'),
('19', '12', 'Adobe photoshop', 'FALSE', 'Accepted'),
('20', '11', 'MS Office ', 'TRUE', 'Accepted'),
('21', '10', 'Apple iMac', 'FALSE', 'Accepted'),
('22', '6', 'Mac OS X', 'FALSE', 'Accepted'),
('23', '7', 'Apple Macbook Air', 'TRUE', 'Accepted'),
('24', '8', 'Windows 7', 'FALSE', 'Accepted'),
('25', '9', 'Mac OS X', 'TRUE', 'Accepted'),
('26', '30', 'Mac OS X', 'FALSE', 'Open'),
('27', '29', 'Apple iMac', 'TRUE', 'Open'),
('28', '28', 'Adobe photoshop', 'FALSE', 'Open'),
('29', '27', 'MS Office', 'TRUE', 'Open'),
('30', '26', 'Apple iMac', 'FALSE', 'Open');


INSERT INTO `Asset` (`AID`, `DateOfIssue`, `ExpiresOn`, `EID`, `ATID`) VALUES
('1', '11/2/19', '11/2/20', '1', 'Apple Macbook Air'),
('2', '12/2/19', '12/2/20', '2', 'Apple iMac'),
('3', '13/2/19', '13/2/20', '3', 'Adobe photoshop'),
('4', '25/2/19', '15/2/20', '4', 'Windows 7'),
('5', '27/2/19', '27/2/20', '5', 'MS Office'),
('6', '1/3/19', '1/3/20', '6', 'Mac OS X'),
('7', '2/3/19', '2/3/20', '7', 'Apple Macbook Air'),
('8', '5/3/19', '5/3/20', '8', 'Windows 7'),
('9', '9/3/19', '9/3/20', '9', 'Mac OS X'),
('10', '10/3/19', '10/3/20', '10', 'Apple iMac'),
('11', '12/3/19', '12/3/20', '11', 'MS Office'),
('12', '15/3/19', '15/3/20', '12', 'Adobe photoshop'),
('13', '20/3/19', '20/3/20', '13', 'Apple iMac'),
('14', '25/3/19', '25/3/20', '14', 'Mac OS X'),
('15', '26/3/19', '26/3/20', '15', 'Apple Macbook Air'),
('16', '29/3/19', '29/3/20', '16', 'Apple Macbook Air'),
('17', '1/4/19', '1/4/20', '17', 'Mac OS X'),
('18', '5/4/19', '5/4/20', '18', 'MS Office'),
('19', '6/4/19', '6/4/20', '19', 'Apple iMac'),
('20', '9/4/19', '9/4/20', '20', 'Windows 7'),
('21', '15/4/19', '15/4/20', '21', 'Adobe photoshop'),
('22', '19/4/19', '19/4/20', '22', 'Apple iMac'),
('23', '25/4/19', '25/4/20', '23', 'Apple Macbook Air'),
('24', '1/5/19', '1/5/20', '24', 'Windows 7'),
('25', '4/5/19', '4/5/20', '25', 'MS Office');




INSERT INTO `SupportTicket` (`TID`,  `ProblemDescription`, `CreatedTime`, `TStatus`,`EID`) VALUES
('2', 'Software not updating', '1', 'Open', 2),
('3', 'Machine not booting', '2', 'Closed', 4),
('4', 'issue with asset', '3', 'Pending', 11),
('5', 'Software not updating', '4', 'Open', 2),
('6', 'Machine not booting', '5', 'Waiting on third party', 21),
('7', 'Software not updating', '6', 'Open', 8),
('8', 'issue with asset', '7', 'Waiting on third party', 4),
('9', 'Software not updating', '8', 'Pending', 2),
('10', 'Machine not booting', '9', 'Waiting on third party', 11),
('11', 'Software not updating', '10', 'Open', 12),
('12', 'issue with asset', '11', 'Pending', 14),
('13', 'Software not updating', '12', 'Waiting on third party', 10),
('14', 'Machine crashing', '13', 'Open', 20),
('15', 'Machine not booting', '14', 'Waiting on third party', 8),
('16', 'Machine crashing', '15', 'Pending', 18),
('17', 'issue with asset', '16', 'Open', 14),
('18', 'Software not updating', '17', 'Waiting on third party', 14),
('19', 'Machine crashing', '18', 'Pending', 21),
('20', 'Machine crashing', '19', 'Waiting on third party', 14),
('21', 'Machine not booting', '20', 'Open', 7),
('22', 'Machine crashing', '21', 'Waiting on third party', 11),
('23', 'issue with asset', '22', 'Pending', 22),
('24', 'Software not updating', '23', 'Waiting on third party', 10),
('25', 'Machine crashing', '24', 'Pending', 5),
('26', 'Machine not booting', '25', 'Waiting on third party', 3),
('27', 'Machine crashing', '26', 'Pending', 2),
('28', 'issue with asset', '27', 'Open', 25),
('29', 'Machine crashing', '28', 'Waiting on third party', 12),
('30', 'Machine crashing', '29', 'Open', 24),
('31', 'Machine crashing', '30', 'Pending', 8),
('32', 'Machine crashing', '31', 'Waiting on third party', 11),
('33', 'Machine crashing', '32', 'Pending', 14),
('34', 'issue with asset', '33', 'Waiting on third party', 14),
('35', 'Machine not booting', '34', 'Pending', 13),
('36', 'Machine not booting', '35', 'Open', 4),
('37', 'Machine not booting', '36', 'Open', 20),
('38', 'Machine not booting', '37', 'Pending', 15),
('39', 'issue with asset', '38', 'Open', 24);

INSERT INTO `Replies` (`RID`,  `RContent`, `EID`, `TID`) VALUES
('2', 'Software not updating', '1', 2),
('3', 'Machine not booting', '2', 4),
('4', 'issue with asset', '3', 11),
('5', 'Software not updating', '4', 2),
('6', 'Machine not booting', '5', 21),
('7', 'Software not updating', '6', 8),
('8', 'issue with asset', '7',  4),
('9', 'Software not updating', '8',  2),
('10', 'Machine not booting', '9', 11),
('11', 'Software not updating', '10', 12)
