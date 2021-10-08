resource "kubernetes_manifest" "customresourcedefinition_clusterworkflowtemplates_argoproj_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "name" = "clusterworkflowtemplates.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind"     = "ClusterWorkflowTemplate"
        "listKind" = "ClusterWorkflowTemplateList"
        "plural"   = "clusterworkflowtemplates"
        "shortNames" = [
          "clusterwftmpl",
          "cwft",
        ]
        "singular" = "clusterworkflowtemplate"
      }
      "scope" = "Cluster"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "apiVersion" = {
                  "type" = "string"
                }
                "kind" = {
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_cronworkflows_argoproj_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "name" = "cronworkflows.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind"     = "CronWorkflow"
        "listKind" = "CronWorkflowList"
        "plural"   = "cronworkflows"
        "shortNames" = [
          "cwf",
          "cronwf",
        ]
        "singular" = "cronworkflow"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "apiVersion" = {
                  "type" = "string"
                }
                "kind" = {
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
                "status" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_workfloweventbindings_argoproj_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "name" = "workfloweventbindings.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind"     = "WorkflowEventBinding"
        "listKind" = "WorkflowEventBindingList"
        "plural"   = "workfloweventbindings"
        "shortNames" = [
          "wfeb",
        ]
        "singular" = "workfloweventbinding"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "apiVersion" = {
                  "type" = "string"
                }
                "kind" = {
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_workflows_argoproj_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "name" = "workflows.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind"     = "Workflow"
        "listKind" = "WorkflowList"
        "plural"   = "workflows"
        "shortNames" = [
          "wf",
        ]
        "singular" = "workflow"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "description" = "Status of the workflow"
              "jsonPath"    = ".status.phase"
              "name"        = "Status"
              "type"        = "string"
            },
            {
              "description" = "When the workflow was started"
              "format"      = "date-time"
              "jsonPath"    = ".status.startedAt"
              "name"        = "Age"
              "type"        = "date"
            },
          ]
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "apiVersion" = {
                  "type" = "string"
                }
                "kind" = {
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
                "status" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served"       = true
          "storage"      = true
          "subresources" = {}
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_workflowtemplates_argoproj_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "name" = "workflowtemplates.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind"     = "WorkflowTemplate"
        "listKind" = "WorkflowTemplateList"
        "plural"   = "workflowtemplates"
        "shortNames" = [
          "wftmpl",
        ]
        "singular" = "workflowtemplate"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "apiVersion" = {
                  "type" = "string"
                }
                "kind" = {
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "type"                                 = "object"
                  "x-kubernetes-map-type"                = "atomic"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_argo" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "name"      = "argo"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_argo_server" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "name"      = "argo-server"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "role_argo_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "Role"
    "metadata" = {
      "name"      = "argo-role"
      "namespace" = "default"
    }
    "rules" = [
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "create",
          "get",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_argo_aggregate_to_admin" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "labels" = {
        "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
      }
      "name" = "argo-aggregate-to-admin"
    }
    "rules" = [
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "workflows",
          "workflows/finalizers",
          "workfloweventbindings",
          "workfloweventbindings/finalizers",
          "workflowtemplates",
          "workflowtemplates/finalizers",
          "cronworkflows",
          "cronworkflows/finalizers",
          "clusterworkflowtemplates",
          "clusterworkflowtemplates/finalizers",
        ]
        "verbs" = [
          "create",
          "delete",
          "deletecollection",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_argo_aggregate_to_edit" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "labels" = {
        "rbac.authorization.k8s.io/aggregate-to-edit" = "true"
      }
      "name" = "argo-aggregate-to-edit"
    }
    "rules" = [
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "workflows",
          "workflows/finalizers",
          "workfloweventbindings",
          "workfloweventbindings/finalizers",
          "workflowtemplates",
          "workflowtemplates/finalizers",
          "cronworkflows",
          "cronworkflows/finalizers",
          "clusterworkflowtemplates",
          "clusterworkflowtemplates/finalizers",
        ]
        "verbs" = [
          "create",
          "delete",
          "deletecollection",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_argo_aggregate_to_view" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "labels" = {
        "rbac.authorization.k8s.io/aggregate-to-view" = "true"
      }
      "name" = "argo-aggregate-to-view"
    }
    "rules" = [
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "workflows",
          "workflows/finalizers",
          "workfloweventbindings",
          "workfloweventbindings/finalizers",
          "workflowtemplates",
          "workflowtemplates/finalizers",
          "cronworkflows",
          "cronworkflows/finalizers",
          "clusterworkflowtemplates",
          "clusterworkflowtemplates/finalizers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_argo_cluster_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "name" = "argo-cluster-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
          "pods/exec",
        ]
        "verbs" = [
          "create",
          "get",
          "list",
          "watch",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "get",
          "watch",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "persistentvolumeclaims",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
        ]
      },
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "workflows",
          "workflows/finalizers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
          "patch",
          "delete",
          "create",
        ]
      },
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "workflowtemplates",
          "workflowtemplates/finalizers",
          "clusterworkflowtemplates",
          "clusterworkflowtemplates/finalizers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "serviceaccounts",
        ]
        "verbs" = [
          "get",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "cronworkflows",
          "cronworkflows/finalizers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "policy",
        ]
        "resources" = [
          "poddisruptionbudgets",
        ]
        "verbs" = [
          "create",
          "get",
          "delete",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_argo_server_cluster_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "name" = "argo-server-cluster-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "get",
          "watch",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "create",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
          "pods/exec",
          "pods/log",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "watch",
          "create",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "serviceaccounts",
        ]
        "verbs" = [
          "get",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "eventsources",
          "sensors",
          "workflows",
          "workfloweventbindings",
          "workflowtemplates",
          "cronworkflows",
          "clusterworkflowtemplates",
        ]
        "verbs" = [
          "create",
          "get",
          "list",
          "watch",
          "update",
          "patch",
          "delete",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_argo_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "RoleBinding"
    "metadata" = {
      "name"      = "argo-binding"
      "namespace" = "default"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "Role"
      "name"     = "argo-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argo"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_argo_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "name" = "argo-binding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "argo-cluster-role"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "argo"
        "namespace" = "argo"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_argo_server_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "name" = "argo-server-binding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "argo-server-cluster-role"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "argo-server"
        "namespace" = "argo"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_workflow_controller_configmap" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "name"      = "workflow-controller-configmap"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "service_argo_server" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "name"      = "argo-server"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "web"
          "port"       = 2746
          "targetPort" = 2746
        },
      ]
      "selector" = {
        "app" = "argo-server"
      }
    }
  }
}

resource "kubernetes_manifest" "service_workflow_controller_metrics" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app" = "workflow-controller"
      }
      "name"      = "workflow-controller-metrics"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "metrics"
          "port"       = 9090
          "protocol"   = "TCP"
          "targetPort" = 9090
        },
      ]
      "selector" = {
        "app" = "workflow-controller"
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_argo_server" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "argo-server"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "argo-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "argo-server"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "server",
              ]
              "image" = "docker.io/argoproj/argocli:v3.1.13"
              "name"  = "argo-server"
              "ports" = [
                {
                  "containerPort" = 2746
                  "name"          = "web"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path"   = "/"
                  "port"   = 2746
                  "scheme" = "HTTPS"
                }
                "initialDelaySeconds" = 10
                "periodSeconds"       = 20
              }
              "securityContext" = {
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/tmp"
                  "name"      = "tmp"
                },
              ]
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
          }
          "serviceAccountName" = "argo-server"
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "tmp"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_workflow_controller" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "workflow-controller"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "workflow-controller"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "workflow-controller"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--configmap",
                "workflow-controller-configmap",
                "--executor-image",
                "argoproj/argoexec:v3.1.13",
              ]
              "command" = [
                "workflow-controller",
              ]
              "env" = [
                {
                  "name" = "LEADER_ELECTION_IDENTITY"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath"  = "metadata.name"
                    }
                  }
                },
              ]
              "image" = "docker.io/argoproj/workflow-controller:v3.1.13"
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 6060
                }
                "initialDelaySeconds" = 90
                "periodSeconds"       = 60
                "timeoutSeconds"      = 30
              }
              "name" = "workflow-controller"
              "ports" = [
                {
                  "containerPort" = 9090
                  "name"          = "metrics"
                },
                {
                  "containerPort" = 6060
                },
              ]
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
                "readOnlyRootFilesystem" = true
                "runAsNonRoot"           = true
              }
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
          }
          "serviceAccountName" = "argo"
        }
      }
    }
  }
}
