IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[DeliverySaverPackageSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPackageSummary] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPackageSummary] not dropped.',16,1)
				
			END
	END
GO
 

CREATE  PROCEDURE [tescosubscription].[DeliverySaverPackageSummary]  
   
 AS 

/*

	Author:			Rangan Thulasi
	Date created:	18 Jan 2012
	Purpose:		
	WarmUP Script:	Execute [tescosubscription].[DeliverySaverPackageSummary]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	27 Jun 2013     Robin                           Removed old logic and added  CONVERT(VARCHAR(10), GETDATE(), 101)  

*/

   
 BEGIN    
 SET NOCOUNT ON    
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    
    
 DECLARE @StartOfDay DATETIME    
      
 SELECT  @StartOfDay = CONVERT(VARCHAR(10), GETDATE(), 101)     
       
 -- package failure error      
 -- both packages included     
 SELECT PM.PackageName    
    FROM tescosubscription.PackageErrorLog Elog     
  JOIN tescosubscription.PackageExecutionHistory PEH ON Elog.PackageExecutionHistoryID = PEH.PackageExecutionHistoryID    
  JOIN tescosubscription.PackageMaster PM ON PM.PackageID = PEH.PackageID    
  WHERE   PEH.PackageStartTime >= @StartOfDay     
  GROUP BY PM.PackageName           
     
     
END        
   
 GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[DeliverySaverPackageSummary] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPackageSummary]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPackageSummary] not created.',16,1)
		
	END
GO
 