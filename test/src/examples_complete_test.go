package test

import (
	"encoding/json"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	randID := strings.ToLower(random.UniqueId())
	attributes := []string{randID}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"attributes": attributes,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	jsonMap := terraform.OutputRequired(t, terraformOptions, "container_definition_json_map")
	// Verify we're getting back the outputs we expect
	var jsonObject map[string]interface{}
	err := json.Unmarshal([]byte(jsonMap), &jsonObject)
	assert.NoError(t, err)
	assert.Equal(t, "geodesic", jsonObject["name"])
	assert.Equal(t, "cloudposse/geodesic", jsonObject["image"])
	assert.Equal(t, 256, int((jsonObject["memory"]).(float64)))
	assert.Equal(t, 128, int((jsonObject["memoryReservation"]).(float64)))
	assert.Equal(t, 256, int((jsonObject["cpu"]).(float64)))
	assert.Equal(t, true, jsonObject["essential"])
	assert.Equal(t, false, jsonObject["readonlyRootFilesystem"])

	// Run `terraform output` to get the value of an output variable
	vpcCidr := terraform.Output(t, terraformOptions, "vpc_cidr")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "172.16.0.0/16", vpcCidr)

	// Run `terraform output` to get the value of an output variable
	privateSubnetCidrs := terraform.OutputList(t, terraformOptions, "private_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.0.0/19", "172.16.32.0/19"}, privateSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	publicSubnetCidrs := terraform.OutputList(t, terraformOptions, "public_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.96.0/19", "172.16.128.0/19"}, publicSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	ecsClusterId := terraform.Output(t, terraformOptions, "ecs_cluster_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "arn:aws:ecs:us-east-2:799847381734:cluster/eg-test-ecs-cloudwatch-autoscaling-" + randID, ecsClusterId)

	// Run `terraform output` to get the value of an output variable
	ecsClusterArn := terraform.Output(t, terraformOptions, "ecs_cluster_arn")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "arn:aws:ecs:us-east-2:799847381734:cluster/eg-test-ecs-cloudwatch-autoscaling-" + randID, ecsClusterArn)

	// Run `terraform output` to get the value of an output variable
	ecsExecRolePolicyName := terraform.Output(t, terraformOptions, "ecs_exec_role_policy_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-ecs-cloudwatch-autoscaling-exec-" + randID, ecsExecRolePolicyName)

	// Run `terraform output` to get the value of an output variable
	serviceName := terraform.Output(t, terraformOptions, "service_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-ecs-cloudwatch-autoscaling-" + randID, serviceName)

	// Run `terraform output` to get the value of an output variable
	serviceRoleArn := terraform.Output(t, terraformOptions, "service_role_arn")
	// Verify we're getting back the outputs we expect
	// We expect service_role_arn to be empty because of this logic update:
	// https://github.com/cloudposse/terraform-aws-ecs-alb-service-task/pull/83
	assert.Equal(t, "", serviceRoleArn)

	// Run `terraform output` to get the value of an output variable
	taskDefinitionFamily := terraform.Output(t, terraformOptions, "task_definition_family")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-ecs-cloudwatch-autoscaling-" + randID, taskDefinitionFamily)

	// Run `terraform output` to get the value of an output variable
	taskExecRoleName := terraform.Output(t, terraformOptions, "task_exec_role_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-ecs-cloudwatch-autoscaling-exec-" + randID, taskExecRoleName)

	// Run `terraform output` to get the value of an output variable
	taskExecRoleArn := terraform.Output(t, terraformOptions, "task_exec_role_arn")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "arn:aws:iam::799847381734:role/eg-test-ecs-cloudwatch-autoscaling-exec-" + randID, taskExecRoleArn)

	// Run `terraform output` to get the value of an output variable
	taskRoleName := terraform.Output(t, terraformOptions, "task_role_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-ecs-cloudwatch-autoscaling-task-" + randID, taskRoleName)

	// Run `terraform output` to get the value of an output variable
	taskRoleArn := terraform.Output(t, terraformOptions, "task_role_arn")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "arn:aws:iam::799847381734:role/eg-test-ecs-cloudwatch-autoscaling-task-" + randID, taskRoleArn)

	// Run `terraform output` to get the value of an output variable
	scaleUpPolicyArn := terraform.Output(t, terraformOptions, "scale_up_policy_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, scaleUpPolicyArn, "eg-test-ecs-cloudwatch-autoscaling-" + randID + "-up")

	// Run `terraform output` to get the value of an output variable
	scaleDownPolicyArn := terraform.Output(t, terraformOptions, "scale_down_policy_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, scaleDownPolicyArn, "eg-test-ecs-cloudwatch-autoscaling-" + randID + "-down")
}
