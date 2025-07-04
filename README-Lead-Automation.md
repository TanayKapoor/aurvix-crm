# 🚀 Aurvix Smart CRM - Lead Automation Setup

This guide covers the automated lead capture and conversion system for the Aurvix Smart CRM project.

## 📋 What's Included

### 1. **Lead Custom Fields**
- `Budget__c` - Currency field for project budget estimation
- `Project_Type__c` - Picklist (E-Commerce, AI Website, Portfolio, Consultation)
- `Lead_Score__c` - Number field (0-100) for lead scoring

### 2. **LeadAutoConvert Flow**
- **Trigger**: Automatically runs when `Lead_Score__c > 75`
- **Actions**:
  - ✅ Converts Lead to Account + Contact
  - ✅ Creates linked Project record
  - ✅ Sends email notification to `tanay@aurvix.xyz`

### 3. **Permission Set**
- `AurvixLeadManagement` - Grants access to all custom fields and objects

---

## 🛠️ Deployment Instructions

### Step 1: Deploy to Your Salesforce Org

```bash
# Navigate to project directory
cd aurvix-crm

# Deploy all metadata
sfdx force:source:deploy --sourcepath force-app/main/default --targetusername your-org-alias

# Or deploy specific components
sfdx force:source:deploy --sourcepath force-app/main/default/objects/Lead/fields --targetusername your-org-alias
sfdx force:source:deploy --sourcepath force-app/main/default/flows --targetusername your-org-alias
sfdx force:source:deploy --sourcepath force-app/main/default/permissionsets --targetusername your-org-alias
```

### Step 2: Assign Permission Set

```bash
# Assign to yourself or specific users
sfdx force:user:permset:assign --permsetname AurvixLeadManagement --targetusername your-org-alias

# Or assign to a specific user
sfdx force:user:permset:assign --permsetname AurvixLeadManagement --onbehalfof user@example.com --targetusername your-org-alias
```

### Step 3: Verify Deployment

1. **Check Custom Fields**: Go to Setup → Object Manager → Lead → Fields & Relationships
2. **Verify Flow**: Setup → Process Automation → Flows → "Lead Auto Convert"
3. **Confirm Permission Set**: Setup → Permission Sets → "Aurvix Lead Management"

---

## 🧪 Testing the Flow

### Manual Testing Steps

1. **Create a Test Lead**:
   ```
   - First Name: John
   - Last Name: Doe
   - Company: Test Company Inc.
   - Email: john.doe@testcompany.com
   - Project Type: AI Website
   - Budget: $50,000
   - Lead Score: 80 (>75 to trigger flow)
   ```

2. **Save the Lead** - The flow should trigger automatically

3. **Verify Results**:
   - ✅ Lead should be converted to Account + Contact
   - ✅ New Project record created and linked to Account
   - ✅ Project status set to "Planning"
   - ✅ Email sent to tanay@aurvix.xyz

### Flow Debug Steps

1. **Enable Debug Logs**:
   - Setup → Debug Logs → New → Select your user
   - Set "Workflow" and "Apex Code" to "FINEST"

2. **Test with Different Scores**:
   - Score ≤ 75: Flow should NOT trigger
   - Score > 75: Flow should trigger conversion

3. **Check Flow History**:
   - Setup → Process Automation → Flows → "Lead Auto Convert" → Run History

---

## 🔌 API Integration Setup

### For Web Form Integration

```javascript
// Example API payload for lead creation
{
  "firstName": "Jane",
  "lastName": "Smith", 
  "company": "Smith Enterprises",
  "email": "jane@smithenterprises.com",
  "phone": "+1-555-123-4567",
  "project_Type__c": "E-Commerce",
  "budget__c": 25000,
  "lead_Score__c": 85,
  "leadSource": "Website",
  "description": "Interested in building an e-commerce platform with AI recommendations"
}
```

### Using Salesforce REST API

```bash
# Create lead via API (example with curl)
curl -X POST https://your-instance.salesforce.com/services/data/v58.0/sobjects/Lead/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "FirstName": "API",
    "LastName": "Test",
    "Company": "API Test Co",
    "Email": "api@test.com",
    "Project_Type__c": "AI Website",
    "Budget__c": 75000,
    "Lead_Score__c": 90
  }'
```

---

## 📊 Lead Scoring Guidelines

### Scoring Criteria (Recommendations)

| Factor | Points | Notes |
|--------|--------|-------|
| **Budget Range** | | |
| $100k+ | 30 pts | Enterprise level |
| $50k-$100k | 25 pts | Mid-market |
| $25k-$50k | 20 pts | Small business |
| <$25k | 10 pts | Starter projects |
| **Project Type** | | |
| AI Website | 25 pts | Core competency |
| E-Commerce | 20 pts | High value |
| Portfolio | 15 pts | Standard |
| Consultation | 10 pts | Discovery |
| **Lead Source** | | |
| Referral | 20 pts | High quality |
| Website | 15 pts | Direct interest |
| Social Media | 10 pts | Awareness stage |
| **Engagement** | | |
| Multiple touchpoints | 15 pts | Engaged |
| Single touchpoint | 5 pts | Initial interest |

### Auto-Conversion Threshold
- **Score > 75**: Automatic conversion + project creation
- **Score 50-75**: Nurture sequence 
- **Score < 50**: Basic follow-up

---

## 🛡️ Security & Permissions

### Required Permissions
- Convert Leads
- Create/Edit Accounts, Contacts, Projects
- Run Flows
- Send Emails

### Permission Set Assignment
```bash
# List users who need access
sfdx force:data:soql:query --query "SELECT Id, Username, Email FROM User WHERE IsActive = true" --targetusername your-org-alias

# Assign permission set
sfdx force:user:permset:assign --permsetname AurvixLeadManagement --onbehalfof username@domain.com --targetusername your-org-alias
```

---

## 🔧 Customization Options

### Modify Flow Trigger Conditions
Edit the flow to change trigger criteria:
- Different lead score threshold
- Additional field conditions
- Time-based triggers

### Email Template Customization
Update the email notification in the flow:
- Change recipient email
- Modify email content
- Add attachments or links

### Project Creation Logic
Customize project record creation:
- Set different default values
- Add more field mappings
- Create additional related records

---

## 📈 Monitoring & Analytics

### Key Metrics to Track
1. **Lead Conversion Rate**: % of leads with score >75
2. **Auto-Conversion Success**: Flow execution success rate  
3. **Project Creation**: Automatic project records created
4. **Email Delivery**: Notification delivery success

### Reports to Create
- High-scoring leads by source
- Conversion rates by project type
- Budget distribution analysis
- Flow performance metrics

---

## 🆘 Troubleshooting

### Common Issues

**Flow Not Triggering**:
- Check if lead score > 75
- Verify flow is Active
- Ensure user has "Run Flow" permission

**Lead Conversion Fails**:
- Check duplicate management rules
- Verify required fields are populated
- Ensure user has "Convert Leads" permission

**Email Not Sending**:
- Verify email deliverability settings
- Check organization email limits
- Confirm recipient email address

**Project Not Created**:
- Check Project__c object permissions
- Verify lookup field relationship
- Review flow debug logs

### Debug Commands
```bash
# Check deployment status
sfdx force:source:deploy:report --targetusername your-org-alias

# View flow details
sfdx force:data:soql:query --query "SELECT Id, MasterLabel, ProcessType, Status FROM FlowDefinitionView WHERE MasterLabel = 'Lead Auto Convert'" --targetusername your-org-alias

# Test permissions
sfdx force:user:permset:list --targetusername your-org-alias
```

---

## 🎯 Next Steps

1. **Deploy and test** the automation
2. **Create lead scoring rules** based on your criteria
3. **Set up web form integration** for automatic lead capture
4. **Build dashboards** for monitoring performance
5. **Create nurture sequences** for leads that don't auto-convert

---

## 📞 Support

For issues or questions:
- Check Salesforce debug logs
- Review flow run history  
- Contact your Salesforce administrator
- Refer to [Salesforce Flow documentation](https://help.salesforce.com/s/articleView?id=sf.flow.htm)

---

*Happy lead converting! 🎉* 