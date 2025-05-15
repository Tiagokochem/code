<?php

namespace App\Domain\Product\Enums;

enum ProductStatus: string
{
    case DRAFT = 'draft';
    case PUBLISHED = 'published';
    case TRASH = 'trash';
}
