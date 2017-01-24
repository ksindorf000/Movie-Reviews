﻿/*
Deployment script for Movie-Reviews

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Movie-Reviews"
:setvar DefaultFilePrefix "Movie-Reviews"
:setvar DefaultDataPath "C:\Users\ksind\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ProjectsV13\"
:setvar DefaultLogPath "C:\Users\ksind\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ProjectsV13\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO

IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[Review]...';


GO
CREATE TABLE [dbo].[Review] (
    [Id]     INT NOT NULL,
    [Person] INT NOT NULL,
    [Movie]  INT NOT NULL,
    [Rating] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO
PRINT N'Creating [dbo].[FK_Review_ToPerson]...';


GO
ALTER TABLE [dbo].[Review] WITH NOCHECK
    ADD CONSTRAINT [FK_Review_ToPerson] FOREIGN KEY ([Person]) REFERENCES [dbo].[Person] ([Id]);


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO
PRINT N'Creating [dbo].[FK_Review_ToMovie]...';


GO
ALTER TABLE [dbo].[Review] WITH NOCHECK
    ADD CONSTRAINT [FK_Review_ToMovie] FOREIGN KEY ([Movie]) REFERENCES [dbo].[Movie] ([Id]);


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT N'The transacted portion of the database update succeeded.'
COMMIT TRANSACTION
END
ELSE PRINT N'The transacted portion of the database update failed.'
GO
DROP TABLE #tmpErrors
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Review] WITH CHECK CHECK CONSTRAINT [FK_Review_ToPerson];

ALTER TABLE [dbo].[Review] WITH CHECK CHECK CONSTRAINT [FK_Review_ToMovie];


GO
PRINT N'Update complete.';


GO