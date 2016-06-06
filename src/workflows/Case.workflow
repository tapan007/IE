<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Yahoo_survey</fullName>
        <description>Send Yahoo survey</description>
        <protected>false</protected>
        <recipients>
            <recipient>tapankbadajena@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>tapankbadajena@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SURVEY_EAT_CAMP_a0oi0000001oTGtAAM</template>
    </alerts>
    <rules>
        <fullName>Send Email</fullName>
        <actions>
            <name>Send_Yahoo_survey</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Type</field>
            <operation>equals</operation>
            <value>Electronic</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>get_lost</fullName>
        <assignedTo>tapankbadajena@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CreatedDate</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>get lost</subject>
    </tasks>
</Workflow>
