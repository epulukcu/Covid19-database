USE [master]
GO
/****** Object:  Database [Covid]    Script Date: 04/01/2022 16:28:27 ******/
CREATE DATABASE [Covid]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Covid', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NEWINSTANCE\MSSQL\DATA\Covid.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Covid_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NEWINSTANCE\MSSQL\DATA\Covid_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Covid] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Covid].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Covid] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Covid] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Covid] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Covid] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Covid] SET ARITHABORT OFF 
GO
ALTER DATABASE [Covid] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Covid] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Covid] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Covid] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Covid] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Covid] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Covid] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Covid] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Covid] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Covid] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Covid] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Covid] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Covid] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Covid] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Covid] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Covid] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Covid] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Covid] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Covid] SET  MULTI_USER 
GO
ALTER DATABASE [Covid] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Covid] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Covid] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Covid] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Covid] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Covid] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Covid', N'ON'
GO
ALTER DATABASE [Covid] SET QUERY_STORE = OFF
GO
USE [Covid]
GO
/****** Object:  Table [dbo].[Egitim]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Egitim](
	[tcno] [nvarchar](11) NOT NULL,
	[lisans] [nvarchar](100) NULL,
	[lisansMezun] [tinyint] NULL,
	[yüksekLisans] [nvarchar](100) NULL,
	[yLisansMezun] [tinyint] NULL,
	[doktora] [nvarchar](100) NULL,
	[doktoraMezun] [tinyint] NULL,
 CONSTRAINT [PK_Personel_Egitim_Bilgileri] PRIMARY KEY CLUSTERED 
(
	[tcno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hastalik]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hastalik](
	[id] [nvarchar](11) NOT NULL,
	[tcno] [nvarchar](11) NULL,
	[hastalıkAdi] [nvarchar](100) NULL,
	[hastalikTarihi] [date] NULL,
	[hastalikBitisTarihi] [date] NULL,
	[belirtiler] [nvarchar](max) NULL,
	[covidPositive] [tinyint] NULL,
	[kronikHastalik] [nvarchar](200) NULL,
	[kronikHastalikDetay] [nvarchar](max) NULL,
 CONSTRAINT [PK_Hastalık] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[5]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[5]
AS
SELECT        1 AS Id, a.lisansMezun AS lisansMezunuSayisi, b.lisansMezunCovidli AS lisansMezunCovidliSayisi, b.lisansMezunCovidli * 100 / a.lisansMezun AS LisansCovidliOrani, a.yLisansMezun AS yuksekLisansMezunuSayisi, 
                         b.yLisansMezunCovidli AS yukseklisansMezunCovidliSayisi, b.yLisansMezunCovidli * 100 / a.yLisansMezun AS YuksekLisansCovidliOrani, a.doktoraMezun AS doktoraMezunuSayisi, 
                         b.doktoraMezunCovidli AS doktoraMezunCovidliSayisi, b.doktoraMezunCovidli * 100 / a.doktoraMezun AS DoktoraCovidliOrani
FROM            (SELECT        COUNT(e.lisansMezun) AS lisansMezun, COUNT(e.yLisansMezun) AS yLisansMezun, COUNT(e.doktoraMezun) AS doktoraMezun
                          FROM            dbo.Hastalik AS h INNER JOIN
                                                    dbo.Egitim AS e ON h.tcno = e.tcno) AS a CROSS JOIN
                             (SELECT        COUNT(e.lisansMezun) AS lisansMezunCovidli, COUNT(e.yLisansMezun) AS yLisansMezunCovidli, COUNT(e.doktoraMezun) AS doktoraMezunCovidli
                               FROM            dbo.Hastalik AS h INNER JOIN
                                                         dbo.Egitim AS e ON h.tcno = e.tcno
                               WHERE        (h.covidPositive = 1)) AS b
GO
/****** Object:  View [dbo].[6_1]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[6_1]
AS
SELECT TOP (3) id, hastalıkAdi, COUNT(hastalıkAdi) AS vakaSayisi, id AS Expr1
FROM     dbo.Hastalik AS h
GROUP BY hastalıkAdi, id
ORDER BY COUNT(*) DESC
GO
/****** Object:  Table [dbo].[Personel]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personel](
	[tcno] [nvarchar](11) NOT NULL,
	[isim] [varchar](50) NULL,
	[soyIsim] [varchar](50) NULL,
	[dogumSehri] [varchar](50) NULL,
	[calismaSaatleriId] [nvarchar](11) NULL,
	[mevkii] [varchar](50) NULL,
	[maas] [varchar](50) NULL,
	[hobiler] [varchar](50) NULL,
 CONSTRAINT [PK_Personel_1] PRIMARY KEY CLUSTERED 
(
	[tcno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[7]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[7]
AS
SELECT TOP (3) h.hastalıkAdi, p.dogumSehri, COUNT(h.hastalıkAdi) AS vakaSayisi, h.id
FROM     dbo.Hastalik AS h INNER JOIN
                  dbo.Personel AS p ON h.tcno = p.tcno
GROUP BY h.hastalıkAdi, p.dogumSehri, h.id
ORDER BY COUNT(*) DESC
GO
/****** Object:  Table [dbo].[Ilac_Recete]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ilac_Recete](
	[IlacId] [nvarchar](11) NOT NULL,
	[ReceteId] [nvarchar](11) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Ilac_Recete] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[8_1]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[8_1]
AS
SELECT TOP (3) IlacId, COUNT(*) AS ilacinKacDefaYazildigi
FROM     dbo.Ilac_Recete
GROUP BY IlacId
ORDER BY ilacinKacDefaYazildigi DESC, IlacId
GO
/****** Object:  View [dbo].[8_2]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[8_2]
AS
SELECT p.tcno, p.isim, p.soyIsim, p.dogumSehri, p.mevkii, p.maas, p.hobiler, h.covidPositive
FROM     dbo.Personel AS p INNER JOIN
                  dbo.Hastalik AS h ON p.tcno = h.tcno
WHERE  (p.tcno IN
                      (SELECT tcno
                       FROM      dbo.Hastalik
                       WHERE   (id IN
                                             (SELECT ReceteId
                                              FROM      dbo.Ilac_Recete
                                              WHERE   (IlacId IN
                                                                    (SELECT IlacId
                                                                     FROM      (SELECT TOP (3) IlacId, COUNT(*) AS IlacınKacDefaYazildigi
                                                                                        FROM      dbo.Ilac_Recete AS Ilac_Recete_1
                                                                                        GROUP BY IlacId
                                                                                        ORDER BY IlacınKacDefaYazildigi DESC) AS a))))))
GO
/****** Object:  Table [dbo].[CovidVaka]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CovidVaka](
	[id] [nvarchar](11) NOT NULL,
	[covidOlumsuzDonduguTarih] [date] NULL,
	[iletisimHalinde] [tinyint] NULL,
	[asiOldu] [tinyint] NULL,
 CONSTRAINT [PK_covid] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[11_1]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Covidli*/
CREATE VIEW [dbo].[11_1]
AS
SELECT        h.tcno, p.isim, p.soyIsim, c.asiOldu, h.hastalıkAdi AS hastalikAdi, h.hastalikTarihi, h.hastalikBitisTarihi, c.id
FROM            dbo.CovidVaka AS c INNER JOIN
                         dbo.Hastalik AS h ON c.id = h.id INNER JOIN
                         dbo.Personel AS p ON h.tcno = p.tcno
WHERE        (h.covidPositive = 1)
GO
/****** Object:  View [dbo].[11_2]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[11_2]
AS
SELECT        1 AS Expr1, a.AsiliCovidliSayisi * 100 / b.covidVakaSayisi AS AsiVurulmaVeCovidliOrani
FROM            (SELECT        COUNT(*) AS AsiliCovidliSayisi
                          FROM            dbo.CovidVaka AS c
                          WHERE        (asiOldu = 1)) AS a CROSS JOIN
                             (SELECT        COUNT(*) AS covidVakaSayisi
                               FROM            dbo.CovidVaka AS c) AS b
GO
/****** Object:  Table [dbo].[Covid_Asi]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Covid_Asi](
	[CovidId] [nvarchar](11) NOT NULL,
	[AsiId] [nvarchar](11) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Covid_Asi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Asi]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asi](
	[id] [nvarchar](11) NOT NULL,
	[asiAdi] [nvarchar](200) NULL,
 CONSTRAINT [PK_Asi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[12]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[12]
AS
SELECT        tcno, kronikHastalik, kronikHastalikDetay, covidPositive, hastalikTarihi, hastalikBitisTarihi, DATEDIFF(HOUR, hastalikTarihi, hastalikBitisTarihi) AS KacSaatteNegatif, id
FROM            dbo.Hastalik AS h
WHERE        (id IN
                             (SELECT        ca.CovidId
                               FROM            dbo.Covid_Asi AS ca INNER JOIN
                                                         dbo.Asi AS a ON ca.AsiId = a.id
                               WHERE        (ca.CovidId IN
                                                             (SELECT        id
                                                               FROM            dbo.Hastalik AS h
                                                               WHERE        (covidPositive = 1) AND (kronikHastalik IS NOT NULL)))
                               GROUP BY ca.CovidId))
GO
/****** Object:  Table [dbo].[Saglik]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saglik](
	[tcno] [nvarchar](11) NOT NULL,
	[kanGrubu] [varchar](8) NULL,
 CONSTRAINT [PK_Personal_Saglik_Bilgileri] PRIMARY KEY CLUSTERED 
(
	[tcno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[13]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[13]
AS
SELECT         ISNULL(ROW_NUMBER() OVER (ORDER BY B.kanGrubu), 0) AS RN,B.kanGrubu, B.kanGrubunaMensupKisiSayısı AS kanGrubunaMensupKisiSayisi, A.covidVakaSayısı AS covidVakaSayisi, A.covidVakaSayısı * 100 / B.kanGrubunaMensupKisiSayısı AS Oran
FROM            (SELECT        s.kanGrubu, COUNT(*) AS covidVakaSayısı
                          FROM            dbo.Hastalik AS h INNER JOIN
                                                    dbo.Saglik AS s ON h.tcno = s.tcno
                          WHERE        (h.covidPositive = 1)
                          GROUP BY s.kanGrubu) AS A INNER JOIN
                             (SELECT        kanGrubu, COUNT(*) AS kanGrubunaMensupKisiSayısı
                               FROM            dbo.Saglik AS s
                               GROUP BY kanGrubu) AS B ON A.kanGrubu = B.kanGrubu
GO
/****** Object:  Table [dbo].[CalismaSaatleri]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalismaSaatleri](
	[id] [nvarchar](11) NOT NULL,
	[pazartesi] [tinyint] NULL,
	[pazartesiCalismaSaatleri] [nvarchar](15) NULL,
	[pazartesiSaat] [int] NULL,
	[sali] [tinyint] NULL,
	[saliCalismaSaatleri] [nvarchar](15) NULL,
	[saliSaat] [int] NULL,
	[carsamba] [tinyint] NULL,
	[carsambaCalismaSaatleri] [nvarchar](15) NULL,
	[carsambaSaat] [int] NULL,
	[persembe] [tinyint] NULL,
	[persembeCalismaSaatleri] [nvarchar](15) NULL,
	[persembeSaat] [int] NULL,
	[cuma] [tinyint] NULL,
	[cumaCalismaSaatleri] [nvarchar](15) NULL,
	[cumaSaat] [int] NULL,
	[cumartesi] [tinyint] NULL,
	[cumartesiCalismaSaatleri] [nvarchar](15) NULL,
	[cumartesiSaat] [int] NULL,
	[pazar] [tinyint] NULL,
	[pazarCalismaSaatleri] [nvarchar](15) NULL,
	[pazarSaat] [int] NULL,
 CONSTRAINT [PK_Calisma_Saatleri] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[14]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[14]
AS
SELECT      ISNULL(ROW_NUMBER() OVER (ORDER BY a.calismaSaatleriId), 0) AS RN, a.calismaSaatleriId, c.pazartesiSaat + c.saliSaat + c.carsambaSaat + c.persembeSaat + c.cumaSaat + c.cumartesiSaat + c.pazarSaat AS haftalikToplamCalismaSuresi, a.buCalismaSaatlerindeCalisanKacCalisanCovidli, 
                         b.buCalismaSaatlerindenKacCalisanVar, a.buCalismaSaatlerindeCalisanKacCalisanCovidli * 100 / b.buCalismaSaatlerindenKacCalisanVar AS Oran
FROM            (SELECT        p.calismaSaatleriId, COUNT(*) AS buCalismaSaatlerindeCalisanKacCalisanCovidli
                          FROM            dbo.Personel AS p INNER JOIN
                                                    dbo.CalismaSaatleri AS z ON p.calismaSaatleriId = z.id INNER JOIN
                                                    dbo.Hastalik AS h ON p.tcno = h.tcno
                          WHERE        (h.covidPositive = 1)
                          GROUP BY p.calismaSaatleriId) AS a INNER JOIN
                             (SELECT        p.calismaSaatleriId, COUNT(*) AS buCalismaSaatlerindenKacCalisanVar
                               FROM            dbo.Personel AS p INNER JOIN
                                                         dbo.CalismaSaatleri AS z ON p.calismaSaatleriId = z.id INNER JOIN
                                                         dbo.Hastalik AS h ON p.tcno = h.tcno
                               GROUP BY p.calismaSaatleriId) AS b ON a.calismaSaatleriId = b.calismaSaatleriId INNER JOIN
                             (SELECT        id, pazartesiSaat, saliSaat, carsambaSaat, persembeSaat, cumaSaat, cumartesiSaat, pazarSaat
                               FROM            dbo.CalismaSaatleri AS z) AS c ON b.calismaSaatleriId = c.id
GO
/****** Object:  View [dbo].[15]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[15]
AS
SELECT        TOP (3) belirtiler, COUNT(*) AS CovidliKacKisideGoruldu, id
FROM            dbo.Hastalik AS h
WHERE        (covidPositive = 1)
GROUP BY belirtiler, id
ORDER BY CovidliKacKisideGoruldu DESC
GO
/****** Object:  Table [dbo].[Temas]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temas](
	[personelTcno] [nvarchar](11) NOT NULL,
	[temasEdilenCovidliPersonelTcno] [nvarchar](11) NOT NULL,
 CONSTRAINT [PK_Temas_1] PRIMARY KEY CLUSTERED 
(
	[personelTcno] ASC,
	[temasEdilenCovidliPersonelTcno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[16]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[16]
AS
SELECT TOP (3) t.personelTcno, p.isim, p.soyIsim AS soyisim, p.mevkii, COUNT(*) AS temasEdilenCovidliSayisi
FROM     dbo.Temas AS t INNER JOIN
                  dbo.Personel AS p ON t.personelTcno = p.tcno
GROUP BY t.personelTcno, p.isim, p.soyIsim, p.mevkii
GO
/****** Object:  View [dbo].[17]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[17]
AS
SELECT        TOP (100) PERCENT h.tcno, a.asiAdi, h.hastalikTarihi, h.hastalikBitisTarihi, DATEDIFF(HOUR, h.hastalikTarihi, h.hastalikBitisTarihi) AS CovidPozitifSuresi, h.id
FROM            dbo.Hastalik AS h INNER JOIN
                         dbo.CovidVaka AS cv ON h.id = cv.id INNER JOIN
                         dbo.Covid_Asi AS ca ON cv.id = ca.CovidId INNER JOIN
                         dbo.Asi AS a ON ca.AsiId = a.id
WHERE        (h.covidPositive = 1)
ORDER BY CovidPozitifSuresi
GO
/****** Object:  View [dbo].[18]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[18]
AS
SELECT        'Haftasonu' AS CalismaGunleri, b.haftasonuKacKisiCalisiyor, a.haftasonuCalisanlardaKacCovidliVar, a.haftasonuCalisanlardaKacCovidliVar * 100 / b.haftasonuKacKisiCalisiyor AS Oran
FROM            (SELECT        p.calismaSaatleriId, COUNT(*) AS haftasonuCalisanlardaKacCovidliVar
                          FROM            dbo.Personel AS p INNER JOIN
                                                    dbo.Hastalik AS h ON p.tcno = h.tcno
                          WHERE        (p.calismaSaatleriId = 2) AND (h.covidPositive = 1)
                          GROUP BY p.calismaSaatleriId) AS a INNER JOIN
                             (SELECT        calismaSaatleriId, COUNT(*) AS haftasonuKacKisiCalisiyor
                               FROM            dbo.Personel AS p
                               WHERE        (calismaSaatleriId = 2)
                               GROUP BY calismaSaatleriId) AS b ON a.calismaSaatleriId = b.calismaSaatleriId CROSS JOIN
                         dbo.CalismaSaatleri AS c
WHERE        (c.id = 2)
GO
/****** Object:  View [dbo].[19]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[19]
AS
SELECT id, tcno, hastalıkAdi AS hastalikAdi, hastalikTarihi, hastalikBitisTarihi, belirtiler, covidPositive, kronikHastalik, kronikHastalikDetay
FROM     dbo.Hastalik AS h
WHERE  (hastalikTarihi > GETDATE() - 30) AND (tcno IN
                      (SELECT tcno
                       FROM      (SELECT TOP (10) tcno, COUNT(*) AS num
                                          FROM      dbo.Hastalik
                                          GROUP BY tcno
                                          ORDER BY num DESC) AS a))
GO
/****** Object:  Table [dbo].[Recete]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recete](
	[id] [nvarchar](11) NOT NULL,
	[tarih] [date] NULL,
	[drAdi] [nvarchar](50) NULL,
	[hastaneAdi] [nvarchar](150) NULL,
 CONSTRAINT [PK_Recete] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ilac]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ilac](
	[id] [nvarchar](11) NOT NULL,
	[ilacAdi] [nvarchar](50) NULL,
	[doz] [nvarchar](50) NULL,
 CONSTRAINT [PK_Ilac] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[20]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[20]
AS
SELECT TOP (100) PERCENT h.id, h.tcno, h.hastalıkAdi AS hastalikAdi, h.hastalikTarihi, h.hastalikBitisTarihi, h.belirtiler, h.covidPositive, h.kronikHastalik, h.kronikHastalikDetay, 'Aşı Olmadı' AS AsiDurumu, r.id AS receteNo, 
                  r.drAdi AS receteyiYazanDoktor, r.hastaneAdi, r.tarih AS receteTarihi, i.ilacAdi, z.EnUzunSüreliCovid AS enUzunSureliCovid
FROM     dbo.Hastalik AS h INNER JOIN
                      (SELECT TOP (1) tcno, MAX(CovidPozitifSüresi) AS EnUzunSüreliCovid
                       FROM      (SELECT h.tcno, DATEDIFF(HOUR, h.hastalikTarihi, h.hastalikBitisTarihi) AS CovidPozitifSüresi
                                          FROM      dbo.Hastalik AS h INNER JOIN
                                                            dbo.CovidVaka AS c ON h.id = c.id
                                          WHERE   (h.covidPositive = 1) AND (c.asiOldu = 0)) AS a
                       GROUP BY tcno
                       ORDER BY EnUzunSüreliCovid DESC) AS z ON h.tcno = z.tcno INNER JOIN
                  dbo.Ilac_Recete AS ir INNER JOIN
                  dbo.Recete AS r ON ir.ReceteId = r.id INNER JOIN
                  dbo.Ilac AS i ON ir.IlacId = i.id ON h.id = r.id
WHERE  (h.hastalikTarihi > GETDATE() - 365)
ORDER BY receteNo DESC
GO
/****** Object:  View [dbo].[10]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[10]
AS
SELECT tcno, isim, soyIsim AS soyisim, dogumSehri, calismaSaatleriId, mevkii, maas, hobiler
FROM     dbo.Personel
WHERE  (tcno IN
                      (SELECT tcno
                       FROM      dbo.Hastalik
                       WHERE   (id IN
                                             (SELECT ca.CovidId
                                              FROM      dbo.Covid_Asi AS ca INNER JOIN
                                                                dbo.Asi AS a ON ca.AsiId = a.id
                                              WHERE   (ca.CovidId IN
                                                                    (SELECT id
                                                                     FROM      dbo.Hastalik AS h
                                                                     WHERE   (covidPositive = 1) AND (kronikHastalik IS NOT NULL))) AND (a.asiAdi LIKE 'Biontech%')
                                              GROUP BY ca.CovidId))))
GO
/****** Object:  View [dbo].[6_2]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[6_2]
AS
SELECT TOP (3) h.hastalıkAdi, p.tcno, p.isim, p.soyIsim, COUNT(h.hastalıkAdi) AS vakaSayisi
FROM     dbo.Hastalik AS h INNER JOIN
                  dbo.Personel AS p ON h.tcno = p.tcno
WHERE  (h.hastalıkAdi IN
                      (SELECT hastalıkAdi
                       FROM      (SELECT TOP (3) hastalıkAdi, id, COUNT(hastalıkAdi) AS vakaSayisi
                                          FROM      dbo.Hastalik AS h
                                          GROUP BY hastalıkAdi, id
                                          ORDER BY COUNT(*) DESC) AS a))
GROUP BY h.hastalıkAdi, p.tcno, p.isim, p.soyIsim, h.hastalıkAdi
ORDER BY COUNT(*) DESC
GO
/****** Object:  View [dbo].[9]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[9]
AS
SELECT h.id, h.tcno, h.hastalıkAdi AS hastalikAdi, h.hastalikTarihi, h.hastalikBitisTarihi, h.belirtiler, h.covidPositive, h.kronikHastalik, h.kronikHastalikDetay, i.ilacAdi
FROM     dbo.Hastalik AS h INNER JOIN
                  dbo.Ilac_Recete AS ir ON h.id = ir.ReceteId INNER JOIN
                  dbo.Ilac AS i ON ir.IlacId = i.id
WHERE  (h.id IN
                      (SELECT ReceteId
                       FROM      dbo.Ilac_Recete
                       WHERE   (IlacId IN
                                             (SELECT IlacId
                                              FROM      dbo.Ilac_Recete AS Ilac_Recete_1))))
GO
/****** Object:  Table [dbo].[Belirti]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Belirti](
	[id] [nvarchar](11) NOT NULL,
	[belirti] [nvarchar](250) NULL,
 CONSTRAINT [PK_Belirti] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Belirti_Covid]    Script Date: 04/01/2022 16:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Belirti_Covid](
	[belirtiId] [nvarchar](11) NOT NULL,
	[covidId] [nvarchar](11) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Belirti_Covid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'1', N'Turkovac 1. Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'2', N'Turkovac 2.Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'3', N'Biontech 1.Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'4', N'Biontech 2.Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'5', N'Biontech 3.Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'6', N'Sinovac 1.Doz')
GO
INSERT [dbo].[Asi] ([id], [asiAdi]) VALUES (N'7', N'Sinovac 2.Doz')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'1', N'Ateş')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'10', N'Koku Kaybı')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'2', N'Öksürük')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'3', N'Baş ağrısı')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'4', N'Ishal')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'5', N'Nefes Darlığı')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'6', N'Tat Kaybı')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'7', N'Halsizlik')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'8', N'Ciltte döküntü')
GO
INSERT [dbo].[Belirti] ([id], [belirti]) VALUES (N'9', N'Bilinç Bulanıklığı')
GO
SET IDENTITY_INSERT [dbo].[Belirti_Covid] ON 
GO
INSERT [dbo].[Belirti_Covid] ([belirtiId], [covidId], [Id]) VALUES (N'1', N'1', 1)
GO
INSERT [dbo].[Belirti_Covid] ([belirtiId], [covidId], [Id]) VALUES (N'1', N'4', 2)
GO
INSERT [dbo].[Belirti_Covid] ([belirtiId], [covidId], [Id]) VALUES (N'2', N'1', 5)
GO
INSERT [dbo].[Belirti_Covid] ([belirtiId], [covidId], [Id]) VALUES (N'2', N'4', 6)
GO
INSERT [dbo].[Belirti_Covid] ([belirtiId], [covidId], [Id]) VALUES (N'3', N'1', 7)
GO
SET IDENTITY_INSERT [dbo].[Belirti_Covid] OFF
GO
INSERT [dbo].[CalismaSaatleri] ([id], [pazartesi], [pazartesiCalismaSaatleri], [pazartesiSaat], [sali], [saliCalismaSaatleri], [saliSaat], [carsamba], [carsambaCalismaSaatleri], [carsambaSaat], [persembe], [persembeCalismaSaatleri], [persembeSaat], [cuma], [cumaCalismaSaatleri], [cumaSaat], [cumartesi], [cumartesiCalismaSaatleri], [cumartesiSaat], [pazar], [pazarCalismaSaatleri], [pazarSaat]) VALUES (N'1', 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:08', 9, 0, NULL, 0, 0, NULL, 0)
GO
INSERT [dbo].[CalismaSaatleri] ([id], [pazartesi], [pazartesiCalismaSaatleri], [pazartesiSaat], [sali], [saliCalismaSaatleri], [saliSaat], [carsamba], [carsambaCalismaSaatleri], [carsambaSaat], [persembe], [persembeCalismaSaatleri], [persembeSaat], [cuma], [cumaCalismaSaatleri], [cumaSaat], [cumartesi], [cumartesiCalismaSaatleri], [cumartesiSaat], [pazar], [pazarCalismaSaatleri], [pazarSaat]) VALUES (N'2', 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9)
GO
INSERT [dbo].[CalismaSaatleri] ([id], [pazartesi], [pazartesiCalismaSaatleri], [pazartesiSaat], [sali], [saliCalismaSaatleri], [saliSaat], [carsamba], [carsambaCalismaSaatleri], [carsambaSaat], [persembe], [persembeCalismaSaatleri], [persembeSaat], [cuma], [cumaCalismaSaatleri], [cumaSaat], [cumartesi], [cumartesiCalismaSaatleri], [cumartesiSaat], [pazar], [pazarCalismaSaatleri], [pazarSaat]) VALUES (N'3', 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9, 1, N'08:00-17:00', 9)
GO
SET IDENTITY_INSERT [dbo].[Covid_Asi] ON 
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'1', N'3', 1)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'1', N'4', 2)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'1', N'6', 3)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'1', N'7', 4)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'4', N'3', 5)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'4', N'4', 6)
GO
INSERT [dbo].[Covid_Asi] ([CovidId], [AsiId], [Id]) VALUES (N'4', N'5', 7)
GO
SET IDENTITY_INSERT [dbo].[Covid_Asi] OFF
GO
INSERT [dbo].[CovidVaka] ([id], [covidOlumsuzDonduguTarih], [iletisimHalinde], [asiOldu]) VALUES (N'1', CAST(N'2021-12-01' AS Date), 0, 1)
GO
INSERT [dbo].[CovidVaka] ([id], [covidOlumsuzDonduguTarih], [iletisimHalinde], [asiOldu]) VALUES (N'4', CAST(N'2021-12-25' AS Date), 1, 1)
GO
INSERT [dbo].[CovidVaka] ([id], [covidOlumsuzDonduguTarih], [iletisimHalinde], [asiOldu]) VALUES (N'6', CAST(N'2021-04-21' AS Date), 0, 0)
GO
INSERT [dbo].[CovidVaka] ([id], [covidOlumsuzDonduguTarih], [iletisimHalinde], [asiOldu]) VALUES (N'8', CAST(N'2021-02-15' AS Date), 1, 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'12345678901', N'Yıldız Teknik', 1, N'Karadeniz Teknik Üniversitesi', 1, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'15486322153', N'Karadeniz Teknik Universitesi', 1, N'Karadeniz Teknik Universitesi', 1, N'Karadeniz Teknik Universitesi', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'23697455785', N'Yıldız Teknik Universitesi', 1, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'25631586477', N'Kültür Universitesi', 1, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'26147962534', N'Doğuş Universitesi', 1, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'27725124612', N'İstanbul Teknik Universitesi', 1, N'İstanbul Teknik Universitesi', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'32698522547', N'MEF Univesitesi', 1, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'63269958512', N'Bogazici Universitesi', 0, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Egitim] ([tcno], [lisans], [lisansMezun], [yüksekLisans], [yLisansMezun], [doktora], [doktoraMezun]) VALUES (N'85524146757', N'Marmara Universitesi', 0, N'NULL', 0, N'NULL', 0)
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'1', N'15486322153', N'COVID', CAST(N'2021-11-20' AS Date), CAST(N'2021-12-01' AS Date), N'Öksürük, baş ağrısı', 1, N'Kronik Astım', N'Nefes almada güçlük')
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'2', N'23697455785', N'Üst solunum yolları enfeksiyonu', CAST(N'2021-10-15' AS Date), CAST(N'2021-10-18' AS Date), N'Burun akıntısı, ateş', 0, NULL, NULL)
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'3', N'25631586477', N'Alt solunum yolu enfeksiyonu', CAST(N'2021-12-20' AS Date), CAST(N'2021-12-22' AS Date), N'Karın ağrısı', 0, NULL, NULL)
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'4', N'26147962534', N'COVID', CAST(N'2021-12-10' AS Date), CAST(N'2021-12-25' AS Date), N'Nefes darlığı', 1, N'Kronik Astım', N'Nefes almada güçlük, konuşmada güçlük, bilinç bulanıklığı.')
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'6', N'27725124612', N'COVID', CAST(N'2021-04-20' AS Date), CAST(N'2021-04-21' AS Date), N'Burun akıntısı, ateş', 1, NULL, NULL)
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'8', N'85524146757', N'COVID', CAST(N'2021-02-09' AS Date), CAST(N'2021-02-15' AS Date), N'Baş ağrısı', 1, NULL, NULL)
GO
INSERT [dbo].[Hastalik] ([id], [tcno], [hastalıkAdi], [hastalikTarihi], [hastalikBitisTarihi], [belirtiler], [covidPositive], [kronikHastalik], [kronikHastalikDetay]) VALUES (N'9', N'85524146757', N'Üst solunum yolları enfeksiyonu', CAST(N'2021-10-15' AS Date), CAST(N'2021-10-15' AS Date), N'Burun akıntısı, ateş', 0, NULL, NULL)
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'1', N'Favicovir', N'8 / gün')
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'2', N'Ercefuryl', N'3 / gün')
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'3', N'Nutriway Daily', N'1 / gün')
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'4', N'Parol', N'4 / gün')
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'5', N'Devit 3', N'1 / gün')
GO
INSERT [dbo].[Ilac] ([id], [ilacAdi], [doz]) VALUES (N'6', N'C Vitamini', N'1 / gün')
GO
SET IDENTITY_INSERT [dbo].[Ilac_Recete] ON 
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'1', N'1', 1)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'1', N'2', 2)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'1', N'6', 4)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'1', N'8', 5)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'2', N'1', 6)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'2', N'2', 7)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'3', N'1', 8)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'5', N'4', 12)
GO
INSERT [dbo].[Ilac_Recete] ([IlacId], [ReceteId], [Id]) VALUES (N'6', N'9', 13)
GO
SET IDENTITY_INSERT [dbo].[Ilac_Recete] OFF
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'12345678901', N'alara', N'dilara', N'Nigde', N'1', N'üst düzey yönetici', N'9000', N'gezmek')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'15486322153', N'Hüseyin', N'Uyanik', N'Istanbul', N'3', N'Stajyer', N'2850', N'kitap okumak')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'23697455785', N'Elif', N'Pulukçu', N'Trabzon', N'1', N'Mühendis', N'5000', N'bisiklete binmek')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'25631586477', N'Sabri', N'Kiliç', N'Kars', N'1', N'Mühendis', N'4500', N'tv seyretmek')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'26147962534', N'Nunis', N'Önder', N'Bursa', N'3', N'Mühendis', N'4700', N'pc oyunu oynamak')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'27725124612', N'Abdullah', N'Aktürk', N'Istanbul', N'1', N'Mühendis', N'6000', N'kod yazmak')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'32698522547', N'Mehmet', N'Soner', N'Istanbul', N'2', N'Teknisyen', N'3800', N'motor sporlari')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'63269958512', N'Ömer', N'Kiremitçi', N'Istanbul', N'1', N'Stajyer', N'2850', N'kampçilik')
GO
INSERT [dbo].[Personel] ([tcno], [isim], [soyIsim], [dogumSehri], [calismaSaatleriId], [mevkii], [maas], [hobiler]) VALUES (N'85524146757', N'Veli', N'Göktürk', N'Rize', N'2', N'Mühendis', N'4700', N'kano yapmak')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'1', CAST(N'2021-11-20' AS Date), N'Dr. Emre Etiler', N'İşyeri hekimi')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'2', CAST(N'2021-10-15' AS Date), N'Dr. Atilla Korkmaz', N'Imperial')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'4', CAST(N'2021-12-10' AS Date), N'Dr. Emre Etiler', N'İşyeri hekimi')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'6', CAST(N'2021-04-20' AS Date), N'Dr. Ahmet Öztürk', N'Doğan Hastanesi')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'8', CAST(N'2021-02-09' AS Date), N'Dr. Emre Etiler', N'İşyeri hekimi')
GO
INSERT [dbo].[Recete] ([id], [tarih], [drAdi], [hastaneAdi]) VALUES (N'9', CAST(N'2021-10-15' AS Date), N'Dr. Yasemin Işık', N'Acıbadem')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'15486322153', N'A RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'23697455785', N'A RH -')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'25631586477', N'A RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'26147962534', N'AB RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'27725124612', N'A RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'32698522547', N'A RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'63269958512', N'AB RH +')
GO
INSERT [dbo].[Saglik] ([tcno], [kanGrubu]) VALUES (N'85524146757', N'B RH -')
GO
INSERT [dbo].[Temas] ([personelTcno], [temasEdilenCovidliPersonelTcno]) VALUES (N'23697455785', N'15486322153')
GO
INSERT [dbo].[Temas] ([personelTcno], [temasEdilenCovidliPersonelTcno]) VALUES (N'23697455785', N'26147962534')
GO
INSERT [dbo].[Temas] ([personelTcno], [temasEdilenCovidliPersonelTcno]) VALUES (N'23697455785', N'27725124612')
GO
INSERT [dbo].[Temas] ([personelTcno], [temasEdilenCovidliPersonelTcno]) VALUES (N'25631586477', N'85524146757')
GO
INSERT [dbo].[Temas] ([personelTcno], [temasEdilenCovidliPersonelTcno]) VALUES (N'85524146757', N'27725124612')
GO
ALTER TABLE [dbo].[Belirti_Covid]  WITH CHECK ADD  CONSTRAINT [FK_Belirti_Covid_Belirti] FOREIGN KEY([belirtiId])
REFERENCES [dbo].[Belirti] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Belirti_Covid] CHECK CONSTRAINT [FK_Belirti_Covid_Belirti]
GO
ALTER TABLE [dbo].[Belirti_Covid]  WITH CHECK ADD  CONSTRAINT [FK_Belirti_Covid_CovidVakasi] FOREIGN KEY([covidId])
REFERENCES [dbo].[CovidVaka] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Belirti_Covid] CHECK CONSTRAINT [FK_Belirti_Covid_CovidVakasi]
GO
ALTER TABLE [dbo].[Covid_Asi]  WITH CHECK ADD  CONSTRAINT [FK_Covid_Asi_Asi] FOREIGN KEY([AsiId])
REFERENCES [dbo].[Asi] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Covid_Asi] CHECK CONSTRAINT [FK_Covid_Asi_Asi]
GO
ALTER TABLE [dbo].[Covid_Asi]  WITH CHECK ADD  CONSTRAINT [FK_Covid_Asi_CovidVakasi] FOREIGN KEY([CovidId])
REFERENCES [dbo].[CovidVaka] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Covid_Asi] CHECK CONSTRAINT [FK_Covid_Asi_CovidVakasi]
GO
ALTER TABLE [dbo].[CovidVaka]  WITH CHECK ADD  CONSTRAINT [FK_CovidVaka_Hastalik] FOREIGN KEY([id])
REFERENCES [dbo].[Hastalik] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CovidVaka] CHECK CONSTRAINT [FK_CovidVaka_Hastalik]
GO
ALTER TABLE [dbo].[Egitim]  WITH CHECK ADD  CONSTRAINT [FK_Egitim_Personel] FOREIGN KEY([tcno])
REFERENCES [dbo].[Personel] ([tcno])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Egitim] CHECK CONSTRAINT [FK_Egitim_Personel]
GO
ALTER TABLE [dbo].[Hastalik]  WITH CHECK ADD  CONSTRAINT [FK_Hastalik_Saglik] FOREIGN KEY([tcno])
REFERENCES [dbo].[Saglik] ([tcno])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Hastalik] CHECK CONSTRAINT [FK_Hastalik_Saglik]
GO
ALTER TABLE [dbo].[Ilac_Recete]  WITH CHECK ADD  CONSTRAINT [FK_Ilac_Recete_Ilac] FOREIGN KEY([IlacId])
REFERENCES [dbo].[Ilac] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ilac_Recete] CHECK CONSTRAINT [FK_Ilac_Recete_Ilac]
GO
ALTER TABLE [dbo].[Ilac_Recete]  WITH CHECK ADD  CONSTRAINT [FK_Ilac_Recete_Recete] FOREIGN KEY([ReceteId])
REFERENCES [dbo].[Recete] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ilac_Recete] CHECK CONSTRAINT [FK_Ilac_Recete_Recete]
GO
ALTER TABLE [dbo].[Personel]  WITH CHECK ADD  CONSTRAINT [FK_Personel_CalismaSaatleri] FOREIGN KEY([calismaSaatleriId])
REFERENCES [dbo].[CalismaSaatleri] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Personel] CHECK CONSTRAINT [FK_Personel_CalismaSaatleri]
GO
ALTER TABLE [dbo].[Recete]  WITH CHECK ADD  CONSTRAINT [FK_Recete_Hastalik] FOREIGN KEY([id])
REFERENCES [dbo].[Hastalik] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Recete] CHECK CONSTRAINT [FK_Recete_Hastalik]
GO
ALTER TABLE [dbo].[Saglik]  WITH CHECK ADD  CONSTRAINT [FK_Saglik_Personel] FOREIGN KEY([tcno])
REFERENCES [dbo].[Personel] ([tcno])
GO
ALTER TABLE [dbo].[Saglik] CHECK CONSTRAINT [FK_Saglik_Personel]
GO
ALTER TABLE [dbo].[Temas]  WITH CHECK ADD  CONSTRAINT [FK_Temas_Personel] FOREIGN KEY([personelTcno])
REFERENCES [dbo].[Personel] ([tcno])
GO
ALTER TABLE [dbo].[Temas] CHECK CONSTRAINT [FK_Temas_Personel]
GO
/****** Object:  StoredProcedure [dbo].[prc61]    Script Date: 04/01/2022 16:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prc61]
AS
BEGIN
	DECLARE @sanal Table 
	(
	 hastalıkAdi varchar(100),
	 vakaSayisi int
	)
	insert into @sanal (hastalıkAdi, vakaSayisi)
	SELECT TOP (3) hastalıkAdi, COUNT(hastalıkAdi) AS vakaSayisi
	FROM     dbo.Hastalik AS h
	GROUP BY hastalıkAdi
	ORDER BY COUNT(*) DESC

	select * from @sanal
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Personel"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 606
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 702
               Bottom = 324
               Right = 1095
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 15
               Left = 1191
               Bottom = 324
               Right = 1541
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 2520
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'11_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'11_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "b"
            Begin Extent = 
               Top = 7
               Left = 302
               Bottom = 104
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 85
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'11_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'11_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'12'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'12'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 7
               Left = 312
               Bottom = 126
               Right = 614
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1356
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'13'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'13'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 467
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 7
               Left = 515
               Bottom = 126
               Right = 871
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 7
               Left = 919
               Bottom = 170
               Right = 1129
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1356
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'14'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'14'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'15'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'15'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 238
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 15
               Left = 768
               Bottom = 324
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'16'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'16'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cv"
            Begin Extent = 
               Top = 15
               Left = 585
               Bottom = 324
               Right = 1095
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ca"
            Begin Extent = 
               Top = 15
               Left = 1191
               Bottom = 238
               Right = 1519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 15
               Left = 1615
               Bottom = 238
               Right = 1943
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'17'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'17'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 7
               Left = 445
               Bottom = 126
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 15
               Left = 1383
               Bottom = 324
               Right = 1861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1356
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'18'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'18'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'19'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'19'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 7
               Left = 537
               Bottom = 126
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ir"
            Begin Extent = 
               Top = 15
               Left = 1062
               Bottom = 238
               Right = 1390
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 15
               Left = 1486
               Bottom = 324
               Right = 1814
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 15
               Left = 1910
               Bottom = 281
               Right = 2238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
En' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'20'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'20'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'20'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 148
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'6_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'6_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 7
               Left = 339
               Bottom = 170
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'6_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'6_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 15
               Left = 601
               Bottom = 324
               Right = 967
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ilac_Recete"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 238
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'8_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'8_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 15
               Left = 96
               Bottom = 324
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 7
               Left = 494
               Bottom = 170
               Right = 721
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'8_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'8_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ir"
            Begin Extent = 
               Top = 7
               Left = 323
               Bottom = 126
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 7
               Left = 565
               Bottom = 148
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'9'
GO
USE [master]
GO
ALTER DATABASE [Covid] SET  READ_WRITE 
GO
