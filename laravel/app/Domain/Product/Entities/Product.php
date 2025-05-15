<?php

namespace App\Domain\Product\Entities;

use Jenssegers\Mongodb\Eloquent\Model;

class Product extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'products';

    protected $fillable = [
        'code',
        'product_name',
        'brands',
        'quantity',
        'categories',
        'labels',
        'cities_tags',
        'purchase_places',
        'stores',
        'ingredients_text',
        'traces',
        'serving_size',
        'serving_quantity',
        'nutriscore_score',
        'nutriscore_grade',
        'main_category',
        'image_url',
        'imported_t',
        'status',
    ];

    protected $casts = [
        'imported_t' => 'datetime',
    ];
}
