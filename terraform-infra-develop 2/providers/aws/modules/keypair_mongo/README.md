## Inputs

| Name                      | Description                                                                          | Type          | Default.     | Required |
|---------------------------|--------------------------------------------------------------------------------------|---------------|--------------|:--------:|
| create_key_pair           | Controls if key pair should be created                                               | `bool`        | `true`       | no       |
| input_key_name            | The name for the key pair.                                                           | `string`      | `ssh_keypair`| no       |
| input_key_name_prefix     | Creates a unique name beginning with the specified prefix. Conflicts with key\_name. | `string`      | `null`       | no       |
| input_tags                | A map of tags to add to key pair resource.                                           | `map(string)` | `{}`         | no       |
| name.                     | Name of the task.                                                                    | `string`      | `OMHE-xxx`   | no       |
| region                    | Name of region                                                                       | `string`      | `us-west-2`  | no.      |

## Outputs
   
| Name                             | Description |
|----------------------------------|-----------------------------------------------------------------------|
| output_key_pair_fingerprint      | The MD5 public key fingerprint as specified in section 4 of RFC 4716. |
| output_key_pair_key_name         | The key pair name.                                                    |
| output_key_pair_key_pair_id      | The key pair ID.                                                      |
| output_key_pair_fingerprint      | The MD5 public key fingerprint as specified in section 4 of RFC 4716. |
