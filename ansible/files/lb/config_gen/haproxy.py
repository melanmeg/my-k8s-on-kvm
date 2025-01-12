# enable flag
enable_cp2_flag = False
enable_cp3_flag = False

# service  # IP  # port  # nodeport
lists = {
    ( 'argocd-test-http',     '192.168.11.161', '80',   '30001' ),
    ( 'argocd-test-https',    '192.168.11.161', '443',  '30002' ),
    ( 'argocd',               '192.168.11.161', '8081', '30003' ),
    ( 'grafana',              '192.168.11.161', '8082', '30004' ),
    ( 'minio',                '192.168.11.161', '8083', '30005' ),
    ( 'longhorn',             '192.168.11.161', '8084', '30006' ),
    ( 'misskey-http',         '192.168.11.161', '8085', '30007' ),
    ( 'misskey-https',        '192.168.11.161', '8086', '30008' ),
    ( 'opensearch',           '192.168.11.161', '8087', '30009' ),
    ( 'opensearch-dashboard', '192.168.11.161', '8088', '30010' ),
    ( 'twicas-monitoring',    '192.168.11.161', '8089', '30011' ),
    ( 'rabbitmq',             '192.168.11.161', '8090', '30012' ),
}

# config gen haproxy
from jinja2 import Template


def generate_script(template_path, output_path, **kwargs):
    with open(template_path, 'r') as file:
        template_content = file.read()
    template = Template(template_content)
    rendered_script = template.render(**kwargs)
    with open(output_path, 'w') as output_file:
        output_file.write(rendered_script)

generate_script('./haproxy_template.cfg.j2', '../haproxy.cfg.j2',
                lists=lists,
                enable_cp2_flag=enable_cp2_flag,
                enable_cp3_flag=enable_cp2_flag
                )
