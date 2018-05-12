USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Procedure [TescoSubscription].[PlanNameGetByID]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [TescoSubscription].[PlanNameGetByID]
** DATE WRITTEN   : 09th July 2013                    
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [TescoSubscription].[PlanNameGetByID] 

		IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [TescoSubscription].[PlanNameGetByID]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [TescoSubscription].[PlanNameGetByID]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [TescoSubscription].[PlanNameGetByID]  does not exist.'
	END
GO