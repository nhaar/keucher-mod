/// FUNCTIONS

function request_version()
{
    instance_create(0, 0, obj_version_checker);
    http_get("https://api.github.com/repos/nhaar/keucher-mod/releases/latest");
}