USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[PreviousInProgressToActive]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[PreviousInProgressToActive]
 DATE WRITTEN   : 06/Nov/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PreviousInProgressToActive]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PreviousInProgressToActive] 

		IF OBJECT_ID(N'[tescosubscription].[PreviousInProgressToActive]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PreviousInProgressToActive]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PreviousInProgressToActive]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[PreviousInProgressToActive]  does not exist.'
	END
GO