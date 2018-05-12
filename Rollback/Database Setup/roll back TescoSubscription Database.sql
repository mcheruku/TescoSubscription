/*

	Created By	: Saritha	k
	Date created: 28 Jul 2011
	Purpose		: ROLLBACK script for database TescoSubscription

	

*/

USE [master] --Swap context to master to release DB connection
GO

IF EXISTS(SELECT 1 FROM sys.databases WHERE [name] = 'TescoSubscription')
BEGIN
	
	DROP DATABASE [TescoSubscription]
	
	IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE [name] = 'TescoSubscription')
	BEGIN
		PRINT 'SUCCESS : Database [TescoSubscription] dropped.'
	END
	ELSE
	BEGIN
		RAISERROR('FAIL : Database [TescoSubscription] not dropped.',16,1)
	END
		
END
ELSE
BEGIN
	PRINT 'NOT EXISTS : Database [TescoSubscription] does not exist.'
END
