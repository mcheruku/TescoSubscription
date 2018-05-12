USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [TescoSubscription].[PlanNameGetByID]

		IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [TescoSubscription].[PlanNameGetByID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [TescoSubscription].[PlanNameGetByID] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [TescoSubscription].[PlanNameGetByID]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[PlanNameGetByID]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [TescoSubscription].[PlanNameGetByID]
(
@SubscriptionPlanID	INT
)
AS
BEGIN

	SELECT PlanName 
	FROM tescosubscription.SubscriptionPlan Sp
	WHERE Sp.SubscriptionPlanID = @SubscriptionPlanID
	
	IF(@@ROWCOUNT > 1 OR @@ROWCOUNT = 0)
	BEGIN
		RAISERROR('ERROR - Procedure [TescoSubscription].[PlanNameGetByID]: multiple name found or plan doesn''t exist',16,1)
	END
	

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [TescoSubscription].[PlanNameGetByID] TO [SubsUser]
GO

IF OBJECT_ID(N'[TescoSubscription].[PlanNameGetByID]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [TescoSubscription].[PlanNameGetByID] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [TescoSubscription].[PlanNameGetByID] not created.',16,1)
	END
GO