 
 [
 {% for key,row in rows.iterrows() %}
 {
    "instruction": "机型配置信息",
    "input": "{{row['机型']}} 机型具体配置信息",
    "output": "{{row['机型']}} 属于 {{row['类型']}} 系列，它是 {{row['cvm_flag']}}，它的详细配置如下：{{row['CPU']}} 核 CPU、{{row['内存']}} GB 内存 和 {{row['系统盘']}} GB 硬盘"
  },
  {% endfor %}
  ]
