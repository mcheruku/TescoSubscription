/*
	Author:		Saritha K
	Created:	13 Sep 2011
	Purpose:	This script to drop the procedure [tescosubscription].[PackageErrorLogCreate]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[PackageErrorLogCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[PackageErrorLogCreate] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[PackageErrorLogCreate] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[PackageErrorLogCreate] - Not exists'
	END 
GO



