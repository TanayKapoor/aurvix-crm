/**
 * @description Utility class for Aurvix Smart CRM
 * @author Aurvix Development Team
 * @date 2025
 */
public with sharing class AurvixUtil {
    
    /**
     * @description Get the current user's information
     * @return User record with basic information
     */
    public static User getCurrentUser() {
        return [SELECT Id, Name, Email, Profile.Name 
                FROM User 
                WHERE Id = :UserInfo.getUserId() 
                LIMIT 1];
    }
    
    /**
     * @description Check if current user is a system administrator
     * @return true if user is system admin, false otherwise
     */
    public static Boolean isSystemAdmin() {
        return [SELECT Id FROM Profile 
                WHERE Id = :UserInfo.getProfileId() 
                AND Name = 'System Administrator' 
                LIMIT 1].size() > 0;
    }
    
    /**
     * @description Generate a friendly greeting message
     * @param userName The name of the user
     * @return Formatted greeting string
     */
    public static String generateGreeting(String userName) {
        String timeOfDay = getTimeOfDay();
        return 'Good ' + timeOfDay + ', ' + userName + '! Welcome to Aurvix Smart CRM.';
    }
    
    /**
     * @description Determine time of day based on current hour
     * @return String representing time of day
     */
    private static String getTimeOfDay() {
        Integer currentHour = System.now().hour();
        
        if (currentHour < 12) {
            return 'morning';
        } else if (currentHour < 17) {
            return 'afternoon';
        } else {
            return 'evening';
        }
    }
} 